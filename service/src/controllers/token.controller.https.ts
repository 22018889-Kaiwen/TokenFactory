import { Body, Controller, Get, Post } from '@nestjs/common';
import { BaseResponse } from 'src/base/base-response';
import { CreateNftCollectionDto, MintNftDto } from './token.dtos';
import { NftService } from 'src/services/ERC721/nft.service';

@Controller('token')
export class TokenController {
  constructor(private readonly nftService: NftService) {}

  @Post('createNftCollection')
  async deployNftCollection(
    @Body() dto: CreateNftCollectionDto,
  ): Promise<BaseResponse> {
    const nftAddress = await this.nftService.createNftCollection(dto);

    return {
      success: true,
      message: 'NFT deployed successfully',
      data: nftAddress,
    };
  }

  @Post('mintNft')
  async mintNft(@Body() dto: MintNftDto): Promise<BaseResponse> {
    const nftAddress = await this.nftService.mintNft(dto);

    return {
      success: true,
      message: 'NFT minted successfully',
      data: nftAddress,
    };
  }

  @Get('getBalance')
  async getBalance(): Promise<BaseResponse> {
    const balance = await this.nftService.getBalance();

    return {
      success: true,
      message: 'Balance fetched successfully',
      data: balance,
    };
  }

  @Get('getVaultAccountAddress')
  async getVaultAccountAddress(): Promise<BaseResponse> {
    const address = await this.nftService.getVaultAccountAddress(
      '2',
      'ETH_TEST5',
    );

    return {
      success: true,
      message: 'Address fetched successfully',
      data: address,
    };
  }
}
