static const char norm_fg[] = "#c7c6c4";
static const char norm_bg[] = "#201b16";
static const char norm_border[] = "#75685f";

static const char sel_fg[] = "#c7c6c4";
static const char sel_bg[] = "#7B8271";
static const char sel_border[] = "#c7c6c4";

static const char urg_fg[] = "#c7c6c4";
static const char urg_bg[] = "#88775A";
static const char urg_border[] = "#88775A";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
