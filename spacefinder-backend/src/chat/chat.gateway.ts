import { WebSocketGateway, WebSocketServer, SubscribeMessage, MessageBody, ConnectedSocket } from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { ChatService } from './chat.service';

@WebSocketGateway({ cors: { origin: '*' } })
export class ChatGateway {
  @WebSocketServer()
  server: Server;

  constructor(private readonly chatService: ChatService) {}

  @SubscribeMessage('joinRoom')
  handleJoinRoom(@MessageBody('bookingId') bookingId: string, @ConnectedSocket() client: Socket) {
    client.join(bookingId);
    return { event: 'joined', data: bookingId };
  }

  @SubscribeMessage('sendMessage')
  async handleMessage(@MessageBody() payload: any, @ConnectedSocket() client: Socket) {
    const message = await this.chatService.createMessage(payload);
    this.server.to(payload.bookingId).emit('newMessage', message);
    return message;
  }

  @SubscribeMessage('markAsRead')
  async handleMarkAsRead(@MessageBody('messageId') messageId: string) {
    await this.chatService.markAsRead(messageId);
    return { event: 'read', data: messageId };
  }
}
