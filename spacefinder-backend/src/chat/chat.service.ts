import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Message } from './entities/message.entity';

@Injectable()
export class ChatService {
  constructor(
    @InjectRepository(Message)
    private messagesRepository: Repository<Message>,
  ) {}

  createMessage(createDto: any) {
    const message = this.messagesRepository.create(createDto);
    return this.messagesRepository.save(message);
  }

  getMessagesByBooking(bookingId: string) {
    return this.messagesRepository.find({
      where: { bookingId },
      order: { createdAt: 'ASC' },
    });
  }

  async markAsRead(messageId: string) {
    await this.messagesRepository.update(messageId, { isRead: true });
  }
}
