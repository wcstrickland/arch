import { LibraryCommandletExecutor } from '@salesforce/salesforcedx-utils-vscode/out/src';
import { CancelResponse, ContinueResponse, ParametersGatherer } from '@salesforce/salesforcedx-utils-vscode/out/src/types';
import * as vscode from 'vscode';
interface ApexExecuteParameters {
    apexCode?: string;
    fileName?: string;
    selection?: vscode.Range;
}
export declare class AnonApexGatherer implements ParametersGatherer<ApexExecuteParameters> {
    gather(): Promise<CancelResponse | ContinueResponse<ApexExecuteParameters>>;
}
export declare class ApexLibraryExecuteExecutor extends LibraryCommandletExecutor<ApexExecuteParameters> {
    static diagnostics: vscode.DiagnosticCollection;
    constructor();
    run(response: ContinueResponse<ApexExecuteParameters>): Promise<boolean>;
    private outputResult;
    private handleDiagnostics;
    private adjustErrorRange;
    private getZeroBasedRange;
}
export declare function forceApexExecute(): Promise<void>;
export {};
