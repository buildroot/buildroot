#include "config.h"
#define IPERF_VERSION VERSION
#define IPERF_VERSION_DATE "12 August 2022"
#define IPERF_VERSION_MAJORHEX 0x00020001
#define IPERF_VERSION_MINORHEX 0x00080003

/*
 * 	case 0:
 *	    sprintf(report->peerversion + strlen(report->peerversion) - 1,"-dev)");
 *	    break;
 *	case 1:
 *	    sprintf(report->peerversion + strlen(report->peerversion) - 1,"-rc)");
 *	    break;
 *	case 2:
 *	    sprintf(report->peerversion + strlen(report->peerversion) - 1,"-rc2)");
 *	    break;
 *	case 3:
 *	    break;
 *	case 4:
 *	    sprintf(report->peerversion + strlen(report->peerversion) - 1,"-private)");
 *	    break;
 *	case 5:
 *	    sprintf(report->peerversion + strlen(report->peerversion) - 1,"-master)");
 * 	    break;
 *	default:
 *	    sprintf(report->peerversion + strlen(report->peerversion) - 1, "-unk)");
 */
