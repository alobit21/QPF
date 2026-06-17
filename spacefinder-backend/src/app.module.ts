import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { getDatabaseConfig } from './config/database.config';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './users/users.module';
import { OfficesModule } from './offices/offices.module';
import { AmenitiesModule } from './amenities/amenities.module';
import { SlotsModule } from './slots/slots.module';
import { BookingsModule } from './bookings/bookings.module';
import { PaymentsModule } from './payments/payments.module';
import { ReviewsModule } from './reviews/reviews.module';
import { ChatModule } from './chat/chat.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    TypeOrmModule.forRoot(getDatabaseConfig()),
    AuthModule,
    UsersModule,
    OfficesModule,
    AmenitiesModule,
    SlotsModule,
    BookingsModule,
    PaymentsModule,
    ReviewsModule,
    ChatModule,
  ],
})
export class AppModule {}
