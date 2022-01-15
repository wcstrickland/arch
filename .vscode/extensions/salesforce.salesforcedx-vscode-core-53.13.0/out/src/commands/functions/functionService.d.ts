import * as vscode from 'vscode';
import { Disposable } from 'vscode';
/**
 * A running task that can be terminated
 */
interface Terminable {
    terminate: () => Promise<void>;
}
/**
 * Tracking locally running functions
 */
export interface FunctionExecution extends Terminable {
    /**
     * root dir where project.toml is located
     */
    rootDir: string;
    /**
     * Local function port
     */
    port: number;
    /**
     * Debug port
     */
    debugPort: number;
    /**
     * Type of debug (node, java)
     */
    debugType: string;
    /**
     * Active debug session attached
     */
    debugSession?: vscode.DebugSession;
}
export declare class FunctionService {
    private static _instance;
    static get instance(): FunctionService;
    /**
     * Locate the directory that has project.toml.
     * If sourceFsPath is the function folder that has project.toml, or a subdirectory
     * or file within that folder, this method returns the function folder by recursively looking up.
     * Otherwise, it returns undefined.
     * @param sourceFsPath path to start function from
     */
    static getFunctionDir(sourceFsPath: string): string | undefined;
    private startedExecutions;
    /**
     * Register started functions, in order to terminate the container.
     * Returns a disposable to unregister in case an error happens when starting function
     *
     * @returns {Disposable} disposable to unregister
     */
    registerStartedFunction(functionExecution: FunctionExecution): Disposable;
    updateFunction(rootDir: string, debugType: string): void;
    isFunctionStarted(): boolean;
    /**
     * Returns the debugType of the first of the startedExecutions as a way to determine the language
     * of all running executions.
     * Current options: 'node', 'java'
     */
    getFunctionLanguage(): any;
    /**
     * Stop all started function containers
     */
    stopFunction(): Promise<void>;
    getStartedFunction(rootDir: string): FunctionExecution | undefined;
    /**
     * Start a debug session that attaches to the debug port of a locally running function.
     * Return if VS Code already has a debug session attached.
     * @param rootDir functions root directory
     */
    debugFunction(rootDir: string): Promise<void>;
    /**
     * Detach the debugger
     * @param rootDir functions root directory
     */
    stopDebuggingFunction(rootDir: string): Promise<void>;
    /**
     * Register listeners for debug session start/stop events and keep track of active debug sessions
     * @param context extension context
     */
    handleDidStartTerminateDebugSessions(context: vscode.ExtensionContext): void;
}
export {};
