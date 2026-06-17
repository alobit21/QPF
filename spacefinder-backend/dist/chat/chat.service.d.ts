import { Repository } from 'typeorm';
import { Message } from './entities/message.entity';
export declare class ChatService {
    private messagesRepository;
    constructor(messagesRepository: Repository<Message>);
    createMessage(createDto: any): Promise<Message[]>;
    getMessagesByBooking(bookingId: string): Promise<Message[]>;
    markAsRead(messageId: string): Promise<void>;
}
