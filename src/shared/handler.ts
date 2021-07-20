export abstract class Handler {
    abstract name: string;
    abstract run(): void;
}

export async function run(handler: Handler) {
    try {
        handler.run();
    } catch (error) {
        warn(`Failed to load handler "${handler.name}" with error "${error}".`);
    }
}