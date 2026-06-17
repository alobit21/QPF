import { Server, Socket } from 'socket.io';
import { ChatService } from './chat.service';
export declare class ChatGateway {
    private readonly chatService;
    server: Server;
    constructor(chatService: ChatService);
    handleJoinRoom(bookingId: string, client: Socket): {
        event: string;
        data: string;
    };
    handleMessage(payload: any, client: Socket): Promise<import("./entities/message.entity").Message[]>;
    handleMarkAsRead(messageId: string): Promise<{
        event: string;
        data: string;
    }>;
}
