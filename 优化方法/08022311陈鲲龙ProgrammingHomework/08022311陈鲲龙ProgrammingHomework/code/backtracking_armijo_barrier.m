function step = backtracking_armijo_barrier(P, q, A, b, x0, t, d, alpha, beta)
% d: search direction
step = 1;

while (true)
    delta_x = step .* d;
    x = x0 + delta_x;
   
    fval_x0 = compute_value_barrier(P, q, A, b, x0, t);
    grad_x0 = compute_grad_barrier(P, q, A, b, x0, t);
    fval_x = compute_value_barrier(P, q, A, b, x, t);
    if (fval_x <= fval_x0 + alpha * grad_x0' * delta_x)
        return;
    end
    step = beta * step;
end
end