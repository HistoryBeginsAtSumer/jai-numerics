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
    assert(n > 0);

    v: Vec;
    v.n = n;
    v._data = NewArray(n, float);

    return v;
}

make_vec :: (a: []float) -> Vec {
    n := a.count;
    v := make_vec(n);

    for i: 0..n-1 {
        v._data[i] = a[i];
    }

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

// a is interpreted as row-major flattened data
make_mat :: (rows: int, cols: int, a: []float) -> Mat {
    assert(rows > 0 && cols > 0);
    assert(rows * cols == a.count);
    mat := make_mat(rows, cols);

    for i: 0..a.count - 1 {
        mat._data[i] = a[i];
    }

    return mat;
}

make_mat :: (rows: int, cols: int, v: Vec) -> Mat {
    return make_mat(rows, cols, v._data);
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

mat_get_row :: (m: *Mat, i: int) -> Vec {
    assert(i >= 0 && i < m.rows);

    v := make_vec(m.cols);

    for j: 0..m.cols - 1 {
        vec_set(*v, j, mat_get(m, i, j));
    }

    return v;
}

mat_get_col :: (m: *Mat, j: int) -> Vec {
    assert(j >= 0 && j < m.cols);

    v := make_vec(m.rows);

    for i: 0..m.rows - 1 {
        vec_set(*v, i, mat_get(m, i, j));
    }

    return v;
}

mat_set :: (m: *Mat, i: int, j: int, x: float) {
    assert(i >= 0 && i < m.rows);
    assert(j >= 0 && j < m.cols);
    m._data[i * m.stride + j] = x;
}

mat_set_row :: (m: *Mat, i: int, x: []float) {
    assert(m.cols == x.count);
    assert(i >= 0 && i < m.rows);

    for j: 0..m.cols - 1 {
        mat_set(m, i, j, x[j]);
    }
}

mat_set_col :: (m: *Mat, j: int, x: []float) {
    assert(j >= 0 && j < m.cols);
    assert(x.count == m.rows);

    for i: 0..m.rows-1 {
        mat_set(m, i, j, x[i]);
    }
}

vec_set :: (v: *Vec, i: int, x: float) {
    assert(i >= 0 && i < v.n);
    v._data[i] = x;
}

mat_print :: (m: *Mat) {
    assert(m != null);
    print("[\n");

    for i: 0..m.rows - 1 {
        print("    ");

        for j: 0..m.cols - 1 {
            print("% ", formatFloat(mat_get(m, i, j), width=10, trailing_width=3, zero_removal=.NO));
        }

        print("\n");
    }

    print("]\n");
}
