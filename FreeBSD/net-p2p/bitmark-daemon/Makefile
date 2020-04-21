# $FreeBSD: head/net-p2p/bitmark-daemon/Makefile 523293 2020-01-17 10:46:13Z araujo $

MASTERDIR=	${.CURDIR}/../bitmark
PKGNAMESUFFIX=	-daemon

COMMENT=	Bitmark distributed property system daemon

CONFLICTS?=	bitmark
SLAVE_PORT=	yes

OPTIONS_DEFINE=		DAEMON
OPTIONS_DEFAULT=	DAEMON

.include "${MASTERDIR}/Makefile"
