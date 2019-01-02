function ret = test_CCALin(X, Y, k, max_T, sep_T, inner_max, epsilon)
    function ret = cp(tilde_Wx, tilde_Wy, Vx, Vy, iters)
        Wx = GS(tilde_Wx, SXX);
        Wy = GS(tilde_Wy, SYY);
        [d1, ~] = size(Wx);
        [d2, ~] = size(Wy);
        cos_x = calc_cos(Wx, Vx, SXX);
        cos_y = calc_cos(Wy, Vy, SYY);
        cos_b = calc_cos([Vx, zeros(d1, k); zeros(d2, k), Vy], ...
                        [tilde_Wx; tilde_Wy], B);
        tcc = TCC(X*Wx, Y*Wy);
        pcc = PCC(X, Y, Wx, Wy, Vx, Vy);
        fprintf('iters:%6d, cos_x=%.3f, cos_y=%.3f, cos_b=%.3f, tcc=.3%f, pcc=%.3f\n', ...
                iters, cos_x, cos_y, cos_b, tcc, pcc);
        % calc_cos([a, 0; 0, b]
        ret = 0;
    end

    [n,d1] = size(X);
    [~,d2] = size(Y);
    X = X-repmat(mean(X,1), n, 1);
    Y = Y-repmat(mean(Y,1), n, 1);
    SXX = X'*X/(n-1);  %d1*d1
    SYY = Y'*Y/(n-1);  %d2*d2
    SXY = X'*Y/(n-1);  %d1*d2
    A = [zeros(d1),SXY; SXY',zeros(d2)]; 
    B = [SXX,zeros(d1,d2); zeros(d2,d1),SYY];
    
%     [Vx, Vy, R, U, V] = canoncorr(X, Y);
    [Vx, Vy] = canoncorr(X, Y);
    Vx = Vx(:, 1:k);
    Vy = Vy(:, 1:k);
    U = normrnd(0,1,2*k,k);
    % ==================== random_test =================
    % 随机生成一个矩阵，看看结果如何
    Wx = rand(d1, 2*k); Wx = Wx*U;
    Wy = rand(d2, 2*k); Wy = Wy*U;
    cp(Wx, Wy, Vx, Vy, 0);
    % =============== W = GenELinK(A,B,T,2*k); ==================
	[d,~] = size(A);
    w = normrnd(0,1,d,k*2);
	w = GS(w, B);
	beta = norm(B);
    alpha = min(abs(eig(B)));
    Q = beta/alpha;
    eta = 1/beta;
%     epsilon = 5e-6;
    for t = 1:max_T
        if mod(t, sep_T) == 0
            Wx = w(1:d1,:);
            Wy = w(d1+1:d1+d2,:);
            Wx = Wx*U;
            Wy = Wy*U;
            % Wx = GS(Wx,SXX);
            % Wy = GS(Wy,SYY);
            cp(Wx, Wy, Vx, Vy, t);
        end
		% disp(t);
		tau = w'*A*w;
		x0 = w*tau;
		g = @(x)(B*x-A*w); 
		w1 = Nesterov(g,x0,Q,eta,inner_max,epsilon);
		w1 = GS(w1, B);
		if norm(w1-w,inf)<epsilon
			break;
		end
		w = w1;
    end
    % ========================================================
	Wx = w(1:d1,:);
	Wy = w(d1+1:d1+d2,:);
	Wx = Wx*U;
	Wy = Wy*U;
	Wx = GS(Wx,SXX);
	Wy = GS(Wy,SYY);

    function y = normR(x,R)
        y = sqrt(x'*R*x);
    end 
    function W =  GS(W,R)
        [d,k]=size(W);
        for j = 1:k
            C = zeros(d,j-1);
            for jj = 1:j-1
                C(:,jj) = W(:,jj)*(W(:,j)'*R*W(:,jj))/(W(:,jj)'*R*W(:,jj));
            end
            W(:,j)=W(:,j)-sum(C,2);
            W(:,j)=W(:,j)/normR(W(:,j),R);
        end
    end
    function y = Nesterov(g,x0,Q,eta,T,epsilon)
        x = x0;
        y = x;
        for m = 1:T
            y1 = x - eta*g(x);
            x = y1 + (sqrt(Q)-1)/(sqrt(Q)+1)*(y1-y);
            if norm(y1-y,inf) < epsilon;
                break;
            end
            y = y1;
        end
    end
end