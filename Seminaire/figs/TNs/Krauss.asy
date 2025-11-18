include "figs/TN.asy";
include "figs/AutoColors.asy.tmp";

externalLegLength = 20 ;
legscale = 6;

Leg i_sys = makeLeg("i_sys", (0, 1));
Leg i_env = makeLeg("i_env", (0, 1),dim=10);
Leg i_sys_p = makeLeg("i_{\rm sys}", (0, 1), side=-1);
Leg i_env_p = makeLeg("i_{\rm env}", (0, 1),dim=10);

Leg i_sys_s = makeLeg("i_sys_s", (0, -1));
Leg i_env_s = makeLeg("i_env_s", (0, -1),dim=10);
Leg i_sys_p_s = makeLeg("i_{\rm sys}'", (0, -1));
Leg i_env_p_s = makeLeg("i_{\rm env}^*", (0, -1),dim=10, side=-1);

Leg a = makeLeg("a", (0, 1), allowBezier=false);
Leg b = makeLeg("b", (0, 1), allowBezier=false);

Tensor psi_sys = makeTensor("$\psi_{\rm sys}$", (-20,25/2), new Leg[] {i_sys}, primary, "circle");
Tensor psi_env = makeTensor("$\psi_{\rm env}$", (20,25/2), new Leg[] {i_env}, primary, "circle");
Tensor inter = makeTensor("$\mathcal{H}_{\rm int}$", (0,60), new Leg[] {dag(i_sys), dag(i_env), i_sys_p, i_env_p}, secondary, "rect", r=30, ratio=0.5);
Tensor inter_prime = makeTensor("$\mathcal{H}_{\rm int}$", inter.pos, new Leg[] {dag(i_sys), i_sys_p, i_env_p}, secondary, "rect", r=30, ratio=0.5);

Tensor psi_env_dag = makeTensor("$\psi_{\rm env}^*$", (20,-25/2), new Leg[] {i_env_s}, primary, "circle");
Tensor psi_sys_dag = makeTensor("$\psi_{\rm sys}^*$", (-20,-25/2), new Leg[] {i_sys_s}, primary, "circle");
Tensor inter_dag = makeTensor("$\mathcal{H}_{\rm int}^\dagger$", -inter.pos, new Leg[] {dag(i_sys_s), dag(i_env_s), i_sys_p_s, i_env_p_s}, secondary, "rect", r=30, ratio=0.5);
Tensor inter_prime_dag = makeTensor("$\mathcal{H}_{\rm int}^\dagger$", -inter_prime.pos, new Leg[] {dag(i_sys_s), i_sys_p_s, i_env_p_s}, secondary, "rect", r=30, ratio=0.5);
Tensor v_id = makeTensor("", (40,0), new Leg[] {i_env_p_s, i_env_p}, "id_v", r = 70, dim=10);

TensorNetwork net = makeTensorNetwork(new Tensor[] {psi_sys, psi_sys_dag, psi_env, psi_env_dag, inter, inter_dag});
TensorNetwork traced = makeTensorNetwork(new Tensor[] {psi_sys, psi_sys_dag, inter_prime, inter_prime_dag, v_id});

picture old = currentpicture;

picture interaction_pic;
currentpicture = interaction_pic;
draw(net);
// shipoutWithMargin(2*lw + 2*gap);


picture interaction_pic_2;
currentpicture = interaction_pic_2;
psi_env.pos += (0, 5);
psi_env_dag.pos += (0, -5);
draw(net);


picture traced_pic;	
currentpicture = traced_pic;
draw(traced);

currentpicture = old;
attach(interaction_pic.fit(), (0,0));
attach(interaction_pic_2.fit(), (150,0));
attach(traced_pic.fit(), (300,0));




shipoutWithMargin(2*lw + 2*gap);