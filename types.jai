Vec :: struct {
    n: int;
    data: *f64;
}

Mat :: struct {
    rows: int;
    cols: int;
    stride: int; // == cols for contiguous row-major
    data: *f64;
}
