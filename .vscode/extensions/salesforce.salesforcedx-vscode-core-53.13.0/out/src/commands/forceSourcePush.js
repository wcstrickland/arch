"use strict";
/*
 * Copyright (c) 2017, salesforce.com, inc.
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
const cli_1 = require("@salesforce/salesforcedx-utils-vscode/out/src/cli");
const messages_1 = require("../messages");
const baseDeployCommand_1 = require("./baseDeployCommand");
const util_1 = require("./util");
class ForceSourcePushExecutor extends baseDeployCommand_1.BaseDeployExecutor {
    constructor(flag) {
        super();
        this.flag = flag;
    }
    build(data) {
        const builder = new cli_1.SfdxCommandBuilder()
            .withDescription(messages_1.nls.localize('force_source_push_default_scratch_org_text'))
            .withArg('force:source:push')
            .withJson()
            .withLogName('force_source_push_default_scratch_org');
        if (this.flag === '--forceoverwrite') {
            builder.withArg(this.flag);
            builder.withDescription(messages_1.nls.localize('force_source_push_force_default_scratch_org_text'));
        }
        return builder.build();
    }
    getDeployType() {
        return baseDeployCommand_1.DeployType.Push;
    }
}
exports.ForceSourcePushExecutor = ForceSourcePushExecutor;
const workspaceChecker = new util_1.SfdxWorkspaceChecker();
const parameterGatherer = new util_1.EmptyParametersGatherer();
function forceSourcePush() {
    return __awaiter(this, void 0, void 0, function* () {
        // tslint:disable-next-line:no-invalid-this
        const flag = this ? this.flag : undefined;
        const executor = new ForceSourcePushExecutor(flag);
        const commandlet = new util_1.SfdxCommandlet(workspaceChecker, parameterGatherer, executor);
        yield commandlet.run();
    });
}
exports.forceSourcePush = forceSourcePush;
//# sourceMappingURL=forceSourcePush.js.map