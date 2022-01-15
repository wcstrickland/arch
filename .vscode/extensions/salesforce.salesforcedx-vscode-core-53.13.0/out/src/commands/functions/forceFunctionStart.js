"use strict";
/*
 * Copyright (c) 2020, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const path = require("path");
const channels_1 = require("../../channels");
const messages_1 = require("../../messages");
const notifications_1 = require("../../notifications");
const telemetry_1 = require("../../telemetry");
const util_1 = require("../../util");
const util_2 = require("../util");
const vscode_1 = require("vscode");
const functionService_1 = require("./functionService");
const constants_1 = require("./types/constants");
const functions_core_1 = require("@heroku/functions-core");
const functions_core_2 = require("@heroku/functions-core");
const src_1 = require("@salesforce/salesforcedx-utils-vscode/out/src");
const channels_2 = require("../../channels");
const LOG_NAME = 'force_function_start';
const forceFunctionStartErrorInfo = {
    force_function_start_docker_plugin_not_installed_or_started: {
        cliMessage: 'Cannot connect to the Docker daemon',
        errorNotificationMessage: messages_1.nls.localize('force_function_start_warning_docker_not_installed_or_not_started')
    }
};
class ForceFunctionStartExecutor extends src_1.LibraryCommandletExecutor {
    constructor() {
        super(messages_1.nls.localize('force_function_start_text'), LOG_NAME, channels_2.OUTPUT_CHANNEL);
        this.cancellable = true;
    }
    run(response, progress, token) {
        return __awaiter(this, void 0, void 0, function* () {
            const sourceFsPath = response.data;
            const functionDirPath = functionService_1.FunctionService.getFunctionDir(sourceFsPath);
            if (!functionDirPath) {
                const warningMessage = messages_1.nls.localize('force_function_start_warning_no_toml');
                notifications_1.notificationService.showWarningMessage(warningMessage);
                telemetry_1.telemetryService.sendException('force_function_start_no_toml', warningMessage);
                return false;
            }
            const functionsBinary = yield functions_core_1.getFunctionsBinary();
            channels_1.channelService.showChannelOutput();
            util_1.OrgAuthInfo.getDefaultUsernameOrAlias(false)
                .then(defaultUsernameorAlias => {
                if (!defaultUsernameorAlias) {
                    const message = messages_1.nls.localize('force_function_start_no_org_auth');
                    channels_1.channelService.appendLine(message);
                    channels_1.channelService.showChannelOutput();
                    notifications_1.notificationService.showInformationMessage(message);
                }
            })
                .catch(error => {
                // ignore, getDefaultUsernameOrAlias catches the error and logs telemetry
            });
            const registeredStartedFunctionDisposable = functionService_1.FunctionService.instance.registerStartedFunction({
                rootDir: functionDirPath,
                port: constants_1.FUNCTION_DEFAULT_PORT,
                debugPort: constants_1.FUNCTION_DEFAULT_DEBUG_PORT,
                debugType: 'node',
                terminate: () => {
                    return new Promise(resolve => resolve(functionsBinary.cancel()));
                }
            });
            this.telemetry.addProperty('language', functionService_1.FunctionService.instance.getFunctionLanguage());
            const writeMsg = (msg) => {
                const outputMsg = msg.text;
                if (outputMsg) {
                    channels_1.channelService.appendLine(outputMsg);
                    const matches = String(outputMsg).match(constants_1.FUNCTION_RUNTIME_DETECTION_PATTERN);
                    if (matches && matches.length > 1) {
                        functionService_1.FunctionService.instance.updateFunction(functionDirPath, matches[1]);
                    }
                }
            };
            const handleError = (error) => {
                registeredStartedFunctionDisposable.dispose();
                let unexpectedError = true;
                Object.keys(forceFunctionStartErrorInfo).forEach(errorType => {
                    var _a;
                    const { cliMessage, errorNotificationMessage } = forceFunctionStartErrorInfo[errorType];
                    if ((_a = error.text) === null || _a === void 0 ? void 0 : _a.includes(cliMessage)) {
                        unexpectedError = false;
                        telemetry_1.telemetryService.sendException(errorType, errorNotificationMessage);
                        notifications_1.notificationService.showErrorMessage(errorNotificationMessage);
                        channels_1.channelService.appendLine(errorNotificationMessage);
                    }
                });
                if (unexpectedError) {
                    const errorNotificationMessage = messages_1.nls.localize('force_function_start_unexpected_error');
                    telemetry_1.telemetryService.sendException('force_function_start_unexpected_error', errorNotificationMessage);
                    notifications_1.notificationService.showErrorMessage(errorNotificationMessage);
                    channels_1.channelService.appendLine(errorNotificationMessage);
                }
                channels_1.channelService.showChannelOutput();
            };
            functionsBinary.on('pack', writeMsg);
            functionsBinary.on('container', writeMsg);
            functionsBinary.on('log', (msg) => {
                if (msg.level === 'debug')
                    return;
                if (msg.level === 'error') {
                    handleError(msg);
                }
                if (msg.text) {
                    writeMsg(msg);
                }
                // evergreen:benny:message {"type":"log","timestamp":"2021-05-10T10:00:27.953248-05:00","level":"info","fields":{"debugPort":"9229","localImageName":"jvm-fn-init","network":"","port":"8080"}} +21ms
                if (msg.fields && msg.fields.localImageName) {
                    channels_1.channelService.appendLine(`'Running on port' :${msg.fields.port}`);
                    channels_1.channelService.appendLine(`'Debugger running on port' :${msg.fields.debugPort}`);
                }
            });
            // Allows for showing custom notifications
            // and sending custom telemtry data for predefined errors
            functionsBinary.on('error', handleError);
            token === null || token === void 0 ? void 0 : token.onCancellationRequested(() => {
                functionsBinary.cancel();
                registeredStartedFunctionDisposable.dispose();
            });
            channels_1.channelService.appendLine('Parsing project.toml');
            const descriptor = yield functions_core_2.getProjectDescriptor(path.join(functionDirPath, 'project.toml'));
            const functionName = descriptor.com.salesforce.id;
            channels_1.channelService.appendLine(`Building ${functionName}`);
            yield functionsBinary.build(functionName, {
                verbose: true,
                path: functionDirPath
            });
            channels_1.channelService.appendLine(`Starting ${functionName}`);
            functionsBinary.run(functionName, {}).catch(err => console.log(err));
            return true;
        });
    }
}
exports.ForceFunctionStartExecutor = ForceFunctionStartExecutor;
/**
 * Executes sfdx run:function:start --verbose
 * @param sourceUri
 */
function forceFunctionStart(sourceUri) {
    var _a;
    return __awaiter(this, void 0, void 0, function* () {
        const startTime = process.hrtime();
        if (!sourceUri) {
            // Try to start function from current active editor, if running SFDX: start function from command palette
            sourceUri = (_a = vscode_1.window.activeTextEditor) === null || _a === void 0 ? void 0 : _a.document.uri;
        }
        if (!sourceUri) {
            const warningMessage = messages_1.nls.localize('force_function_start_warning_not_in_function_folder');
            notifications_1.notificationService.showWarningMessage(warningMessage);
            telemetry_1.telemetryService.sendException('force_function_start_not_in_function_folder', warningMessage);
            return;
        }
        const commandlet = new util_2.SfdxCommandlet(new util_2.SfdxWorkspaceChecker(), new util_2.FilePathGatherer(sourceUri), new ForceFunctionStartExecutor());
        yield commandlet.run();
    });
}
exports.forceFunctionStart = forceFunctionStart;
//# sourceMappingURL=forceFunctionStart.js.map