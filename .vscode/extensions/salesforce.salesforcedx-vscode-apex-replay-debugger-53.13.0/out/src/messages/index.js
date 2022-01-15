"use strict";
/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * Licensed under the BSD 3-Clause license.
 * For full license text, see LICENSE.txt file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
Object.defineProperty(exports, "__esModule", { value: true });
const i18n_1 = require("@salesforce/salesforcedx-apex-replay-debugger/node_modules/@salesforce/salesforcedx-utils-vscode/out/src/i18n");
function loadMessageBundle(config) {
    function resolveFileName(locale) {
        return locale === i18n_1.DEFAULT_LOCALE
            ? `${i18n_1.BASE_FILE_NAME}.${i18n_1.BASE_FILE_EXTENSION}`
            : `${i18n_1.BASE_FILE_NAME}.${locale}.${i18n_1.BASE_FILE_EXTENSION}`;
    }
    const base = new i18n_1.Message(require(`./${resolveFileName(i18n_1.DEFAULT_LOCALE)}`).messages);
    if (config && config.locale && config.locale !== i18n_1.DEFAULT_LOCALE) {
        try {
            const layer = new i18n_1.Message(require(`./${resolveFileName(config.locale)}`).messages, base);
            return layer;
        }
        catch (e) {
            console.error(`Cannot find ${config.locale}, defaulting to en`);
            return base;
        }
    }
    else {
        return base;
    }
}
exports.nls = new i18n_1.Localization(loadMessageBundle(process.env.VSCODE_NLS_CONFIG
    ? JSON.parse(process.env.VSCODE_NLS_CONFIG)
    : undefined));
//# sourceMappingURL=index.js.map