mat_at :: (m: *Mat, i: int, j: int) -> *f64 {
    assert(i >= 0 && i < m.rows);
    assert(j >= 0 && j < m.cols);
    return m.data + i*m.stride + j;
}

vec_at :: (v: *Vec, i: int) -> *f64 {
    assert(i >= 0 && i < v.n);
    return v.data + i;
}
