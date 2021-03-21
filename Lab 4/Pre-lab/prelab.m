%% a)
G_s = tf(1, [1 3.2 0]);

%% b)
rlocus(G_s);

%% c)
z = 6;
p = 15.51;
Gc_s = tf([1 z], [1 p]);

%% d)
P_s = series(Gc_s, G_s);

%% e)
figure()
rlocus(P_s);
hold on;

%% f)
k_c = 0.6976;
G_s = series(G_s, 4.7);
Gc_s = series(Gc_s, k_c);
scaled_P_s = series(G_s, Gc_s);

%% g)
T_s = feedback(scaled_P_s, 1)

%% h) & i)
poles = pole(T_s)

%% j)

