#ifndef crypto_int8_h
#define crypto_int8_h

typedef signed char crypto_int8;

static crypto_int8 crypto_int8_negative_mask(crypto_int8 crypto_int8_x)
{
  return crypto_int8_x >> 7;
}

static crypto_int8 crypto_int8_nonzero_mask(crypto_int8 crypto_int8_x)
{
  return crypto_int8_negative_mask(crypto_int8_x) | crypto_int8_negative_mask(-crypto_int8_x);
}

static crypto_int8 crypto_int8_zero_mask(crypto_int8 crypto_int8_x)
{
  return ~crypto_int8_nonzero_mask(crypto_int8_x);
}

static crypto_int8 crypto_int8_positive_mask(crypto_int8 crypto_int8_x)
{
  crypto_int8 crypto_int8_z = -crypto_int8_x;
  crypto_int8_z ^= crypto_int8_x & crypto_int8_z;
  return crypto_int8_negative_mask(crypto_int8_z);
}

static crypto_int8 crypto_int8_unequal_mask(crypto_int8 crypto_int8_x,crypto_int8 crypto_int8_y)
{
  crypto_int8 crypto_int8_xy = crypto_int8_x ^ crypto_int8_y;
  return crypto_int8_nonzero_mask(crypto_int8_xy);
}

static crypto_int8 crypto_int8_equal_mask(crypto_int8 crypto_int8_x,crypto_int8 crypto_int8_y)
{
  return ~crypto_int8_unequal_mask(crypto_int8_x,crypto_int8_y);
}

static crypto_int8 crypto_int8_smaller_mask(crypto_int8 crypto_int8_x,crypto_int8 crypto_int8_y)
{
  crypto_int8 crypto_int8_xy = crypto_int8_x ^ crypto_int8_y;
  crypto_int8 crypto_int8_z = crypto_int8_x - crypto_int8_y;
  crypto_int8_z ^= crypto_int8_xy & (crypto_int8_z ^ crypto_int8_x);
  return crypto_int8_negative_mask(crypto_int8_z);
}

static crypto_int8 crypto_int8_min(crypto_int8 crypto_int8_x,crypto_int8 crypto_int8_y)
{
  crypto_int8 crypto_int8_xy = crypto_int8_y ^ crypto_int8_x;
  crypto_int8 crypto_int8_z = crypto_int8_y - crypto_int8_x;
  crypto_int8_z ^= crypto_int8_xy & (crypto_int8_z ^ crypto_int8_y);
  crypto_int8_z = crypto_int8_negative_mask(crypto_int8_z);
  crypto_int8_z &= crypto_int8_xy;
  return crypto_int8_x ^ crypto_int8_z;
}

static crypto_int8 crypto_int8_max(crypto_int8 crypto_int8_x,crypto_int8 crypto_int8_y)
{
  crypto_int8 crypto_int8_xy = crypto_int8_y ^ crypto_int8_x;
  crypto_int8 crypto_int8_z = crypto_int8_y - crypto_int8_x;
  crypto_int8_z ^= crypto_int8_xy & (crypto_int8_z ^ crypto_int8_y);
  crypto_int8_z = crypto_int8_negative_mask(crypto_int8_z);
  crypto_int8_z &= crypto_int8_xy;
  return crypto_int8_y ^ crypto_int8_z;
}

static void crypto_int8_minmax(crypto_int8 *crypto_int8_a,crypto_int8 *crypto_int8_b)
{
  crypto_int8 crypto_int8_x = *crypto_int8_a;
  crypto_int8 crypto_int8_y = *crypto_int8_b;
  crypto_int8 crypto_int8_xy = crypto_int8_y ^ crypto_int8_x;
  crypto_int8 crypto_int8_z = crypto_int8_y - crypto_int8_x;
  crypto_int8_z ^= crypto_int8_xy & (crypto_int8_z ^ crypto_int8_y);
  crypto_int8_z = crypto_int8_negative_mask(crypto_int8_z);
  crypto_int8_z &= crypto_int8_xy;
  *crypto_int8_a = crypto_int8_x ^ crypto_int8_z;
  *crypto_int8_b = crypto_int8_y ^ crypto_int8_z;
}

#endif
