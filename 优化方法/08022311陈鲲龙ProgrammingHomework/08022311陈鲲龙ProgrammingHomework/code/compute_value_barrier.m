function value = compute_value_barrier(P, q, A, b, x, t)
    if (~all(A * x <= b)) 
        value = Inf;
    else
        value = compute_value_qp(P, q, x);
        value = t * value - sum(log(b - A * x));
    end
end