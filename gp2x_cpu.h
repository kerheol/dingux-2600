#if !defined(GCW0_MODE)
#if defined(GP2X_MODE)
#include "cpugp2x.h"
#elif defined(WIZ_MODE)
#include "cpuwiz.h"
#elif defined(DINGUX_MODE)
#include "cpudingux.h"
#else
#include "cpuno.h"
#endif
#else
# define GP2X_DEF_CLOCK     0
# define GP2X_DEF_EMU_CLOCK 0
# define GP2X_MIN_CLOCK     0
# define GP2X_MAX_CLOCK     0
#endif