import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';

import { TokenController } from './controllers/token.controller.https';
import { ConfigModule } from 'src/config/config.module';
import { DatabaseModule } from 'src/database/database.module';
import { NftModel, NftsRepository } from './services/ERC721/nft.model';
import { NftService } from './services/ERC721/nft.service';

const models: any[] = [NftModel];
const modules: any[] = [];

const repositories: any[] = [NftsRepository];
const services: any[] = [NftService];

const controllers: any[] = [TokenController];
@Module({
  imports: [
    ConfigModule,
    DatabaseModule.register({ models }),
    HttpModule,
    ...modules,
  ],
  providers: [...repositories, ...services],
  controllers: controllers,
})
export class AppModule {}
