import * as vscode from 'vscode';
import { LanguageClient, LanguageClientOptions } from 'vscode-languageclient';
export declare function setupDB(): void;
export declare function code2ProtocolConverter(value: vscode.Uri): string;
export declare function createLanguageServer(context: vscode.ExtensionContext): Promise<LanguageClient>;
export declare function buildClientOptions(): LanguageClientOptions;
