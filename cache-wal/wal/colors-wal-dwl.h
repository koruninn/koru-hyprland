/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x201b16ff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc7c6c4ff, 0x201b16ff, 0x75685fff },
	[SchemeSel]  = { 0xc7c6c4ff, 0x7B8271ff, 0x88775Aff },
	[SchemeUrg]  = { 0xc7c6c4ff, 0x88775Aff, 0x7B8271ff },
};
