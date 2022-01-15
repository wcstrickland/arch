import { ContinueResponse } from '@salesforce/salesforcedx-utils-vscode/out/src/types';
import * as vscode from 'vscode';
import { Uri } from 'vscode';
import { LibraryCommandletExecutor } from '@salesforce/salesforcedx-utils-vscode/out/src';
export declare class ForceFunctionStartExecutor extends LibraryCommandletExecutor<string> {
    constructor();
    run(response: ContinueResponse<string>, progress?: vscode.Progress<{
        message?: string | undefined;
        increment?: number | undefined;
    }>, token?: vscode.CancellationToken): Promise<boolean>;
}
/**
 * Executes sfdx run:function:start --verbose
 * @param sourceUri
 */
export declare function forceFunctionStart(sourceUri?: Uri): Promise<void>;
