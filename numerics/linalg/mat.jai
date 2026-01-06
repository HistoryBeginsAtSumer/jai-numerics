Vec :: struct {
    n: int;
    _data: []float;
}

Mat :: struct {
    rows: int;
    cols: int;
    stride: int; // == cols for contiguous row-major
    _data: []float;
}

make_vec :: (n: int) -> Vec {
    v: Vec;
    v.n = n;
    v._data = NewArray(n, float);
    return v;
}

make_mat :: (rows: int, cols: int) -> Mat {
    assert(rows > 0);
    assert(cols > 0);
    m: Mat;
    m.rows = rows;
    m.cols = cols;
    m.stride = cols;
    m._data = NewArray(rows * cols, float);
    return m;
}

mat_get :: (m: *Mat, i: int, j: int) -> float {
    assert(i >= 0 && i < m.rows);
    assert(j >= 0 && j < m.cols);
    return m._data[i * m.stride + j];
}

vec_get :: (v: *Vec, i: int) -> float {
    assert(i >= 0 && i < v.n);
    return v._data[i];
}

mat_set :: (m: *Mat, i: int, j: int, x: float) {
    assert(i >= 0 && i < m.rows);
    assert(j >= 0 && j < m.cols);
    m._data[i * m.stride + j] = x;
}

vec_set :: (v: *Vec, i: int, x: float) {
    assert(i >= 0 && i < v.n);
    v._data[i] = x;
}

mat_print :: (m: *Mat) {
    print("[\n");

    for i: 0..m.rows - 1 {
        print("    ");

        for j: 0..m.cols - 1 {
            print("% ", mat_get(m, i, j));
        }

        print("\n");
    }

    print("]\n");
}
