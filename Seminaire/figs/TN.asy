// This defines a tensor network drawing library
// It allows to draw tensor networks with legs and nodes with a reusable interface
import graph;

real lw = 2.5;        // line width for legs and outlines
real r  = 12;          // node radius (pt)
real gap  = 1;        // label distance from node along leg
real legscale = 8.0;
real externalLegLength = 25;

defaultpen(fontsize(12pt));

pen leg  = linewidth(lw) + black;
pen edge = linewidth(lw) + black;

// Define leg before tensor uses it
struct Leg {
  string idx;      // index name
  bool dag;
  pair dir;      // direction in degrees (use dir(dir))
  real length;     // leg length in pt
  int dim;         // optional: dimension of index
  int side;        // +1 or -1: label side
  string label;    // optional; default = "$"+idx+"$"
  pen color;
  bool allowBezier;
  int labelStrength; // 0: none, 1: visible, 2: visible even if bezier
}

Leg makeLeg(string idx, bool dag = false, pair dir = (0,1), real length = externalLegLength, int side=+1, int dim=2, string label="", pen color=black, bool allowBezier=true, int labelStrength=1)
{
  Leg L; L.idx=idx; L.dir=dir; L.length=length; L.side=side; L.dim=dim; L.label=label; L.color=color; L.allowBezier=allowBezier; L.labelStrength=labelStrength; return L;
}

// Basic tensor node
struct Tensor {
  pair pos;
  string label;
  pen color;
  string shape;
  real r;
  int dim; // dimension of the index (used only to draw the indentity tensor for now)
  real ratio; // ratio of the width to the height if the shape is a rectangle
  Leg[] legs;
  Leg[][] groups;
}
Tensor makeTensor(string label, pair pos, Leg[] legs, pen color=black, string shape="circle", real r=r, int dim=2, real ratio=1)
{
  Tensor t; t.label=label; t.pos=pos; t.legs=legs; t.color=color; t.shape=shape; t.r=r; t.dim=dim; t.ratio=ratio; return t;
}

// --------- Convenience functions ---------
pair getGroupIndex(Tensor t, Leg L)
{
  for (int gi = 0; gi < t.groups.length; ++gi) {
    if (t.groups[gi][0].dir == L.dir) {
      for (int li = 0; li < t.groups[gi].length; ++li) {
        if (t.groups[gi][li] == L) {
          return (li, t.groups[gi].length);
        }
      }
    }
  }
  return (-1,-1);
}
real getGroupOffset(Tensor t, Leg L)
{

  pair groupData = getGroupIndex(t, L);
  real groupIdx = groupData.x;
  real groupLen = groupData.y;
  real dist = 1/(groupLen + 1);
  real offset = t.r*(-1/2 + dist*(groupIdx+1))*2;
  return offset;
}

pair visibleMidpoint(pair a, pair b, real radiusA=0, real radiusB=0)
{
  pair ab = b - a;
  real L = length(ab);
  if (L == 0) return a; // degenerate segment
  pair u = ab / L; // unit direction from a to b

  real trimA = (radiusA > L) ? L : radiusA;
  real trimB = (radiusB > L) ? L : radiusB;

  pair startVisible = a + trimA * u;
  pair endVisible   = b - trimB * u;
//   filldraw(circle(startVisible, 5), red);
//   filldraw(circle(endVisible, 5), green);

  return interp(startVisible, endVisible, 0.5);
}

// Unit-length perpendicular to segment a->b; side=+1 for CW, -1 for CCW
pair perpUnitCW(pair a, pair b, int side)
{
  pair v = b - a;
  real L = length(v);
  if (L == 0) return (0,0);
  pair u = v / L;
  pair cw = (u.y, -u.x);   // rotate 90° clockwise
  return (side >= 0 ? cw : -cw);
}

void labelPerpVisible(string s, pair a, pair b, real radiusA=0, real radiusB=0, int side=+1)
{
  pair mp = visibleMidpoint(a, b, radiusA, radiusB);
  pair n  = perpUnitCW(a, b, side);
  label(s, mp, gap*n);
}

// Ship out with a uniform margin around the figure
void shipoutWithMargin(real m)
{
  // Expand bounds with x/y margins m and no visible frame
  shipout(bbox(m, m, nullpen));
}

// -------------- Tensor Network helpers --------------

// Network container
struct TensorNetwork {
  Tensor[] tensors;
}

TensorNetwork makeTensorNetwork(Tensor[] tensors)
{
  TensorNetwork net; net.tensors=tensors; return net;
}

pen get_width(int dim)
{
  return linewidth(log10(dim) * legscale);
}

// Resolve leg label with sensible default
string legLabel(Leg L)
{
  return (L.label == "" ? "$"+L.idx+"$" : L.label);
}

// Attachment point at node boundary for a leg
pair portPoint(Tensor t, Leg L)
{
  if (t.shape == "circle") {
    return t.pos + dir(degrees(L.dir))*t.r;
  } else if (t.shape == "square") {
    return t.pos + dir(degrees(L.dir))*t.r;
  } else if (t.shape == "diamond") {
    return t.pos + dir(degrees(L.dir))*t.r;
  } else if (t.shape == "triangle") {
    return t.pos + dir(degrees(L.dir))*t.r*2/3;
  } else if (t.shape == "id_h") {
    real offset;
    if (L.dir.x > 0) {
      offset = t.r;
    } else {
      offset = -t.r;
    }
    return t.pos + (offset, 0);
  } else if (t.shape == "id_v") {
    real offset;
    if (L.dir.y > 0) {
      offset = t.r;
    } else {
      offset = -t.r;
    }
    return t.pos + (0, offset);
  } else if (t.shape == "rect") {
    pair thedir = dir(degrees(L.dir));
    return t.pos + (thedir.x*t.r, thedir.y*t.r*t.ratio);
  } else {
    return (0,0);
  }
}

void labelBezier(path bezier, string label)
{
  pair p1 = point(bezier, 0);
  pair p2 = point(bezier, 1);
  pair mp = visibleMidpoint(p1, p2);
  label(label, mp);
}

// Draw only the tensor body (node + center label)
void drawTensorBody(Tensor t)
{
  if (t.shape == "circle") {
    filldraw(circle(t.pos, t.r), t.color, edge);
  } else if (t.shape == "square") {
    filldraw(box(t.pos - (t.r, t.r), t.pos + (t.r, t.r)), t.color, edge);
  } else if (t.shape == "triangle") {
    // h = 2 * l * sin(angle/2) = 2r => l = r / sin(angle/2)
    // w = l * cos(angle/2)
    real angle = pi/3;
    real l = t.r / sin(angle/2);
    real w = l * cos(angle/2);
    pair A = (0, 0);
    pair B = (l, 0);
    pair C = (l*cos(angle), l*sin(angle));
    path tri = shift((-w/2,0))*rotate(degrees(-angle/2))*(A--B--C--cycle);
    //esthetic shift
    tri = shift((-w/6,0))*tri;
    //if a vector (one leg) rotate the triangle to face the leg direction
    if (t.legs.length == 1) {
      tri = rotate(degrees(t.legs[0].dir))*tri;
    }
    filldraw(shift(t.pos)*tri, t.color, edge);
  } else if (t.shape == "id_h") {
    draw(t.pos-t.r--t.pos+t.r, get_width(t.dim) + t.color);
  } else if (t.shape == "id_v") {
    draw(t.pos+(0, -t.r)--t.pos+(0, t.r), get_width(t.dim) + t.color);
  } else if (t.shape == "diamond") {
    filldraw(shift(t.pos)*rotate(45)*box((-t.r/sqrt(2), -t.r/sqrt(2)), (t.r/sqrt(2), t.r/sqrt(2))), t.color, edge);
  } else if (t.shape == "rect") {
    filldraw(shift(t.pos)*box((-t.r, -t.r*t.ratio), (t.r, t.r*t.ratio)), t.color, edge);
  }
  if (t.label != "") label(t.label, t.pos);
}


// Draw an external (dangling) leg for a tensor
void drawConnection(Tensor t1, Tensor t2, Leg L1, Leg L2, bool bezier=true)
{
  pair start = portPoint(t1, L1);
  pair end = portPoint(t2, L2);
  real offset1 = getGroupOffset(t1, L1);
  real offset2 = getGroupOffset(t2, L2);
  pen leg = get_width(L1.dim) + L1.color;
  start = start + (offset1, 0);
  end = end + (offset2, 0);
  if (L1.allowBezier) {
    path bezier = (start){dir(degrees(L1.dir))*L1.length}..{-dir(degrees(L2.dir))*L2.length}(end);
    draw(bezier, leg);
    if (L1.labelStrength == 2) {
      labelBezier(bezier, legLabel(L1));
    }
  } else {
    draw(t1.pos--t2.pos, leg);
    if (L1.labelStrength > 0) {
      labelPerpVisible(legLabel(L1), t1.pos, t2.pos, r, r, L1.side);
    }
  }
}

void drawLeg(Leg L, pair start, pair end, real radiusStart=0, real radiusEnd=0, bool bezier=true)
{
  // make the width the log of the dim of the leg
  pen leg = get_width(L.dim) + L.color;
  draw(start--end, leg);
  labelPerpVisible(legLabel(L), start, end, radiusStart, radiusEnd, L.side);
}

void drawExternalLeg(Tensor t, Leg L)
{
  
  real offset = getGroupOffset(t, L);
  //real offset = 0;
  pair a = t.pos + (offset, 0);
  pair b = portPoint(t, L) + dir(degrees(L.dir))*L.length + (offset, 0);
  drawLeg(L, a, b, t.r, 0);
}
// Draw an internal edge between two tensor legs; place index label mid-edge
void drawEdge(Tensor tA, Tensor tB, Leg L)
{
//   pair a = portPoint(tA, LA, r);
//   pair b = portPoint(tB, LB, r);
  pair a = tA.pos;
  pair b = tB.pos;
  drawLeg(L, a, b, tA.r, tB.r);
}

// Auto-connect repeated indices; odd leftovers become external legs
void drawTensorNetwork(TensorNetwork net)
{
  
  // create a list of tensor pairs
  Tensor[][] tensorPairs;
  Leg[][] summedLegsPairs;
  string[] sharedIndices;
  for (int ti1 = 0; ti1 < net.tensors.length; ++ti1) {
    Tensor tA = net.tensors[ti1];
    for (int ti2 = ti1 + 1; ti2 < net.tensors.length; ++ti2) {
      Tensor tB = net.tensors[ti2];
      for (int li1 = 0; li1 < tA.legs.length; ++li1) {
      // check if leg is also in tB
      Leg LA = tA.legs[li1];
      for (int li2 = 0; li2 < tB.legs.length; ++li2) {
        Leg LB = tB.legs[li2];
        if (LA.idx == LB.idx) {
          tensorPairs.push(new Tensor[] {tA, tB});
          summedLegsPairs.push(new Leg[] {LA, LB});
          sharedIndices.push(LA.idx);
        }
      }
      }
    }
  }

  // find indices pointing in the same direction

  for (int i = 0; i < net.tensors.length; ++i) {
    Tensor t = net.tensors[i];
    t.groups = new Leg[][];
    for (int li = 0; li < t.legs.length; ++li) {
      bool found_existing_group = false;
      for (int gi = 0; gi < t.groups.length; ++gi) {
        if (t.groups[gi][0].dir == t.legs[li].dir) {
          t.groups[gi].push(t.legs[li]);
          found_existing_group = true;
          break;
        }
      }
      if (!found_existing_group) {
        t.groups.push(new Leg[] {t.legs[li]});
      }
    }
  }
  
  for (int i = 0; i < tensorPairs.length; ++i) {
    Tensor[] tPair = tensorPairs[i];
    Leg[] sLegs = summedLegsPairs[i];
    drawConnection(tPair[0], tPair[1], sLegs[0], sLegs[1]);
  }

  // Draw dangling legs
  for (int i = 0; i < net.tensors.length; ++i) {
    Tensor t = net.tensors[i];
    for (int j = 0; j < t.legs.length; ++j) {
      Leg L = t.legs[j];
      // check that the leg is not in the summedLegs list
      bool isSummed = false;
      for (int k = 0; k < sharedIndices.length; ++k) {
        if (sharedIndices[k] == L.idx) {
          isSummed = true;
          break;
        }
      }
      if (!isSummed) {
        drawExternalLeg(t, L);
      }
    }
  }

  // Draw nodes last
  for (int i = 0; i < net.tensors.length; ++i) {
    Tensor t = net.tensors[i];
    drawTensorBody(t);
  }
}

// -------------- Friendly draw overloads --------------

void draw(Tensor t)
{
  drawTensorBody(t);
  for (int i=0; i<t.legs.length; ++i) drawExternalLeg(t, t.legs[i]);
}

void draw(Tensor[] ts)
{
  for (int i=0; i<ts.length; ++i) draw(ts[i]);
}

void draw(TensorNetwork net)
{
  drawTensorNetwork(net);
}

Leg copy(Leg L)
{
  Leg copy = new Leg;
  copy.idx = L.idx;
  copy.dag = L.dag;
  copy.dir = L.dir;
  copy.length = L.length;
  copy.dim = L.dim;
  copy.side = L.side;
  copy.label = L.label;
  copy.color = L.color;
  copy.allowBezier = L.allowBezier;
  copy.labelStrength = L.labelStrength;
  return copy;
}
Leg dag(Leg L)
{
  Leg L2 = copy(L);
  L2.dir = -L2.dir;
  L2.side = -L2.side;
  return L2;
}
