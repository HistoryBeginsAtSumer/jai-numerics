#load "../numerics/numerics.jai";

#import "Basic";

main :: () {
    // Parameters
    scale := 0.01;
    true_intercept := 1.;
    true_coef := make_vec(float.[ 2., -1., 0. ]);
    size := 10;
    ndim := true_coef.n;

    // Mock data
    X := make_mat(size, ndim, gaussian_rng(0., 1., size * ndim));
    y := mat_mult(*X, *true_coef);
    vec_add(*y, true_intercept);
    e := gaussian_rng(0., scale, size);
    vec_add(*y, *e);

    // Parameter estimation
    fit_intercept := true;
    intercept, coef := ols_fit(*X, *y, fit_intercept);

    // Printing the feature matrix
    print("X = ");
    mat_print(*X);

    // Printing the response vector
    print("y = %\n", y._data);

    // Printing the regression coefficients
    print("intercept = %\n", intercept);
    print("coef = %\n", coef._data);
}
