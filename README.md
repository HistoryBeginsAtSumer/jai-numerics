# Numerics

A proposal for a first-class numerical computing module in Jai

## Purpose

`numerics` exists to make numerical and statistical programming a first-class
capability of the Jai ecosystem, without burdening the core language or forcing
external dependencies onto users.

It provides practical, mainstream numerical tools—dense arrays, linear algebra,
and foundational statistics—with an emphasis on clarity, correctness, and
predictable performance.

## Scope

`numerics` targets the common, real-world use cases of numerical computing:

- dense numerical arrays and views,
- linear algebra for solving systems and least-squares problems,
- core statistical routines used in modeling and analysis.

It explicitly avoids:

- symbolic mathematics,
- domain-specific modeling frameworks,
- experimental or niche algorithms.

## Design Principles

1. **Official, but Optional**

   `numerics` is intended as a Tier-1 standard module: shipped, documented, and
   versioned with Jai, but imported explicitly and not required by
   non-numerical programs.

2. **Friction Reduction Over Abstraction**

   The module prioritizes removing unnecessary friction over introducing clever
   abstractions. APIs are explicit, boring, and predictable.

3. **Correctness Before Cleverness**

   Numerical stability, edge-case handling, and clearly documented behavior
   take precedence over minimal code size or theoretical elegance.

4. **Performance Without Mystery**

   Implementations aim for high performance while remaining readable and
   auditable. Optimizations must be explainable and testable.

5. **Stable Public Surface**

   Public APIs are designed to remain stable even as internal implementations
   evolve.

6. **Progressive Independence**

   Where appropriate, well-established numerical libraries may be used
   initially. Over time, critical routines are replaced with native
   implementations validated against independent test oracles.

## Non-Goals

`numerics` does not attempt to:

- replicate the full scope of NumPy, SciPy, or statsmodels,
- expose every available numerical algorithm,
- impose a single mathematical worldview or workflow.

## Long-Term Vision

`numerics` aims to become the obvious and trusted foundation for numerical work in Jai: not because it is exhaustive or fashionable, but because it is correct, available, and unsurprising.
