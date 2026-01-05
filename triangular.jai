solve_lower :: (L: *Mat, b: *Vec, x: *Vec) {
    n := L.rows;
    for i: 0..n-1 {
        s := b.data[i];
        for j: 0..i-1 {
            s -= *mat_at(L, i, j) * x.data[j];
        }
        x.data[i] = s / *mat_at(L, i, i);
    }
}

solve_upper_transpose :: (L: *Mat, y: *Vec, x: *Vec) {
    n := L.rows;
    for i: n-1..0 {
        s := y.data[i];
        for j: i+1..n-1 {
            s -= *mat_at(L, j, i) * x.data[j];
        }
        x.data[i] = s / *mat_at(L, i, i);
    }
}
