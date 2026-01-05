make_vec :: (n: int) -> Vec {
    v: Vec;
    v.n = n;
    v.data = cast(*f64) alloc(n * size_of(f64));
    return v;
}

make_mat :: (rows: int, cols: int) -> Mat {
    m: Mat;
    m.rows = rows;
    m.cols = cols;
    m.stride = cols;
    m.data = cast(*f64) alloc(rows * cols * size_of(f64));
    return m;
}

free_vec :: (v: *Vec) {
    free(v.data);
}

free_mat :: (m: *Mat) {
    free(m.data);
}
