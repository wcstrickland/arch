import { workspace, WorkspaceFolder } from 'vscode';
export declare function hasRootWorkspace(ws?: typeof workspace): boolean | undefined;
export declare function getRootWorkspace(): WorkspaceFolder;
export declare function getRootWorkspacePath(): string;
