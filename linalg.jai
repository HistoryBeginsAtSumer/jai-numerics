dot :: (x: *Vec, y: *Vec) -> f64 {
    assert(x.n == y.n);
    s: f64 = 0;
    for i: 0..x.n-1 {
        s += x.data[i] * y.data[i];
    }
    return s;
}

gemv :: (A: *Mat, x: *Vec, out: *Vec) {
    assert(A.cols == x.n);
    assert(A.rows == out.n);

    for i: 0..A.rows-1 {
        s: f64 = 0;
        row := A.data + i*A.stride;
        for j: 0..A.cols-1 {
            s += row[j] * x.data[j];
        }
        out.data[i] = s;
    }
}
