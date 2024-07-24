import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class CreateNftCollectionDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  readonly name: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  readonly symbol: string;
}

export class MintNftDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  readonly tokenAddress: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  readonly to: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  readonly tokenURI: string;
}
