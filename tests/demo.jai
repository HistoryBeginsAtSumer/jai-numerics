#load "../numerics/numerics.jai";

#import "Basic";

main :: () {
    // Parameters
    size := 10;
    ndim := 3;
    scale := 0.01;
    intercept := 1.;
    true_coef := make_vec(3);
    true_coef._data = float.[2., -1., 0.];
    fit_intercept := true;

    // Generating test data
    offset := ifx fit_intercept then 1 else 0;
    X := make_mat(size, ndim + offset);
    y := gaussian_rng(0., scale, size);

    if fit_intercept {
        for i: 0..size - 1 {
            mat_set(*X, i, 0, 1.0);
        }
    }

    row := make_vec(ndim);
    for i: 0..size - 1 {
        x1 := cast(float) i;
        mat_set(*X, i, offset, x1);

        x2 := cast(float)(i % 2);
        mat_set(*X, i, offset + 1, x2);

        x3 := rand();
        mat_set(*X, i, offset + 2, x3);

        row._data = float.[x1, x2, x3];
        mean := intercept + dot(*true_coef, *row);
        noise := vec_get(*y, i);
        vec_set(*y, i, mean + noise);
    }

    // Parameter estimation
    coef := ols_fit(*X, *y);

    // Printing the feature matrix
    print("X = ");
    mat_print(*X);

    // Printing the response vector
    print("y = %\n", y._data);

    // Printing the regression coefficients
    print("coef = %\n", coef._data);
}
