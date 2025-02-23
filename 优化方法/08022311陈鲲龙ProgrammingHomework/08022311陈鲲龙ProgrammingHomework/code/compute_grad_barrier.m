function grad = compute_grad_barrier(P, q, A, b, x, t)
    grad = compute_grad_qp(P, q, x);
    residual = b - A * x;
    grad = t * grad + A' * (1 ./ residual);
end