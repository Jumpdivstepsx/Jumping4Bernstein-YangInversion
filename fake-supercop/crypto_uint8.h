#ifndef crypto_uint8_h
#define crypto_uint8_h

typedef unsigned char crypto_uint8;

typedef signed char crypto_uint8_signed;

static crypto_uint8_signed crypto_uint8_signed_negative_mask(crypto_uint8_signed crypto_uint8_signed_x)
{
  return crypto_uint8_signed_x >> 7;
}

static crypto_uint8 crypto_uint8_nonzero_mask(crypto_uint8 crypto_uint8_x)
{
  return crypto_uint8_signed_negative_mask(crypto_uint8_x) | crypto_uint8_signed_negative_mask(-crypto_uint8_x);
}

static crypto_uint8 crypto_uint8_zero_mask(crypto_uint8 crypto_uint8_x)
{
  return ~crypto_uint8_nonzero_mask(crypto_uint8_x);
}

static crypto_uint8 crypto_uint8_unequal_mask(crypto_uint8 crypto_uint8_x,crypto_uint8 crypto_uint8_y)
{
  crypto_uint8 crypto_uint8_xy = crypto_uint8_x ^ crypto_uint8_y;
  return crypto_uint8_nonzero_mask(crypto_uint8_xy);
}

static crypto_uint8 crypto_uint8_equal_mask(crypto_uint8 crypto_uint8_x,crypto_uint8 crypto_uint8_y)
{
  return ~crypto_uint8_unequal_mask(crypto_uint8_x,crypto_uint8_y);
}

static crypto_uint8 crypto_uint8_smaller_mask(crypto_uint8 crypto_uint8_x,crypto_uint8 crypto_uint8_y)
{
  crypto_uint8 crypto_uint8_xy = crypto_uint8_x ^ crypto_uint8_y;
  crypto_uint8 crypto_uint8_z = crypto_uint8_x - crypto_uint8_y;
  crypto_uint8_z ^= crypto_uint8_xy & (crypto_uint8_z ^ crypto_uint8_x ^ (((crypto_uint8) 1) << 7));
  return crypto_uint8_signed_negative_mask(crypto_uint8_z);
}

static crypto_uint8 crypto_uint8_min(crypto_uint8 crypto_uint8_x,crypto_uint8 crypto_uint8_y)
{
  crypto_uint8 crypto_uint8_xy = crypto_uint8_y ^ crypto_uint8_x;
  crypto_uint8 crypto_uint8_z = crypto_uint8_y - crypto_uint8_x;
  crypto_uint8_z ^= crypto_uint8_xy & (crypto_uint8_z ^ crypto_uint8_y ^ (((crypto_uint8) 1) << 7));
  crypto_uint8_z = crypto_uint8_signed_negative_mask(crypto_uint8_z);
  crypto_uint8_z &= crypto_uint8_xy;
  return crypto_uint8_x ^ crypto_uint8_z;
}

static crypto_uint8 crypto_uint8_max(crypto_uint8 crypto_uint8_x,crypto_uint8 crypto_uint8_y)
{
  crypto_uint8 crypto_uint8_xy = crypto_uint8_y ^ crypto_uint8_x;
  crypto_uint8 crypto_uint8_z = crypto_uint8_y - crypto_uint8_x;
  crypto_uint8_z ^= crypto_uint8_xy & (crypto_uint8_z ^ crypto_uint8_y ^ (((crypto_uint8) 1) << 7));
  crypto_uint8_z = crypto_uint8_signed_negative_mask(crypto_uint8_z);
  crypto_uint8_z &= crypto_uint8_xy;
  return crypto_uint8_y ^ crypto_uint8_z;
}

static void crypto_uint8_minmax(crypto_uint8 *crypto_uint8_a,crypto_uint8 *crypto_uint8_b)
{
  crypto_uint8 crypto_uint8_x = *crypto_uint8_a;
  crypto_uint8 crypto_uint8_y = *crypto_uint8_b;
  crypto_uint8 crypto_uint8_xy = crypto_uint8_y ^ crypto_uint8_x;
  crypto_uint8 crypto_uint8_z = crypto_uint8_y - crypto_uint8_x;
  crypto_uint8_z ^= crypto_uint8_xy & (crypto_uint8_z ^ crypto_uint8_y ^ (((crypto_uint8) 1) << 7));
  crypto_uint8_z = crypto_uint8_signed_negative_mask(crypto_uint8_z);
  crypto_uint8_z &= crypto_uint8_xy;
  *crypto_uint8_a = crypto_uint8_x ^ crypto_uint8_z;
  *crypto_uint8_b = crypto_uint8_y ^ crypto_uint8_z;
}

#endif
