function grad2 = compute_grad2_barrier(P, q, A, b, x, t)
    grad2 = compute_grad2_qp(P, q, x);
    residual = b - A * x;
    r = 1 ./ (residual .^ 2);
    grad2 = t .* grad2 + A' * diag(r) * A;
end