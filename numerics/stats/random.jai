#import "Math";

// ----------------------------------------------------------------------------
// Deterministic PRNG (simple xorshift* style)
// ----------------------------------------------------------------------------
// This is NOT cryptographic.
//
_rng_state: u64 = 42;
_XORSHIFT_MULTIPLIER :: 2_685_821_657_736_338_717;
_NORMALIZING_CONST :: cast(float32)1. / 4_294_967_296.;

rand :: () -> float {
    // xorshift64*
    x := _rng_state;
    x ^= x >> 12;
    x ^= x << 25;
    x ^= x >> 27;
    _rng_state = x;

    u := cast(u32)((x * _XORSHIFT_MULTIPLIER) >> 32);

    // map to (0, 1)
    return (cast(float)u + cast(float)0.5) * cast(float)_NORMALIZING_CONST;
}

_box_muller :: () -> (float, float) {
    u1 := rand();
    u2 := rand();

    r := sqrt(-2. * log(u1));
    theta := 2. * PI * u2;

    z0 := r * cos(theta);
    z1 := r * sin(theta);

    return z0, z1;
}

gaussian_rng :: (loc: float = 0., scale: float = 1., size: int = 1) -> Vec {
    assert(scale > 0.);
    assert(size > 0);

    half_size := size / 2;
    out := make_vec(size);

    for i: 0..half_size - 1 {
        z1, z2 := _box_muller();
        vec_set(*out, i, loc + scale * z1);
        vec_set(*out, i + half_size, loc + scale * z2);
    }

    if size % 2 == 1 {
        z1, _ := _box_muller();
        vec_set(*out, size - 1, loc + scale * z1);
    }

    return out;
}
