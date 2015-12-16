# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmark-daemon
#PORTVERSION=	1.0.0
#DISTVERSIONPREFIX=	v
PORTVERSION=	bf7c854

CATEGORIES=	net-p2p

MAINTAINER=	hsw@bitmark.com
COMMENT=	The Bitmark distributed property daemon

LICENSE=	ISCL

BUILD_DEPENDS=	go:${PORTSDIR}/lang/go

ONLY_FOR_ARCHS=	i386 amd64


USE_GITHUB=	yes

GH_ACCOUNT=	bitmark-inc:DEFAULT \
		agl:ed25519 \
		cihub:seelog \
		pebbe:zmq4 \
		syndtr:goleveldb \
		golang:golang_snappy

GH_PROJECT=	bitmarkd:bitmarkd \
		bilateralrpc:bilateralrpc \
		certgen:certgen \
		ed25519:ed25519 \
		exitwithstatus:exitwithstatus \
		go-libucl:go_libucl \
		goleveldb:goleveldb \
		listener:listener \
		logger:logger \
		seelog:seelog \
		snappy:golang_snappy \
		zmq4:zmq4

GH_TAGNAME=	bf7c854:bitmarkd \
		dee6fef:bilateralrpc \
		c8407fd:certgen \
		1d600d0:exitwithstatus \
		3ac2803:go_libucl \
		5b92961:listener \
		cd56291:logger \
		278e1ec:ed25519 \
		1a9d62f:goleveldb \
		5841159:seelog \
		723cc1e:golang_snappy \
		943819a:zmq4

STRIP=		# stripping can break go binaries

PLIST_FILES=	sbin/bitmarkd \
		etc/bitmarkd.conf.sample

post-patch:
.for account in bitmark-inc agl cihub golang pebbe syndtr
	@${MKDIR} ${WRKSRC}/src/github.com/${account}
.endfor

	${MKDIR} ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.for src in LICENSE \
		README.md \
		announce \
		background \
		bitmarkd.conf-sample \
		bitmarkd.go \
		block \
		certificates.go \
		chain \
		commands.go \
		configuration \
		counter \
		difficulty \
		doc.go \
		fault \
		getoptions \
		gnomon \
		issue-generator \
		keypair.go \
		limitedset \
		messagebus \
		mine \
		mode \
		payment \
		peer \
		pool \
		rpc \
		stub-server.go \
		transaction \
		util \
		version.go
	@${MV} ${WRKSRC}/${src} ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.endfor
	@${MV} ${WRKSRC_bilateralrpc} ${WRKSRC}/src/github.com/bitmark-inc/bilateralrpc
	@${MV} ${WRKSRC_certgen} ${WRKSRC}/src/github.com/bitmark-inc/certgen
	@${MV} ${WRKSRC_exitwithstatus} ${WRKSRC}/src/github.com/bitmark-inc/exitwithstatus
	@${MV} ${WRKSRC_go_libucl} ${WRKSRC}/src/github.com/bitmark-inc/go-libucl
	@${MV} ${WRKSRC_listener} ${WRKSRC}/src/github.com/bitmark-inc/listener
	@${MV} ${WRKSRC_logger} ${WRKSRC}/src/github.com/bitmark-inc/logger
	@${MV} ${WRKSRC_ed25519} ${WRKSRC}/src/github.com/agl/ed25519
	@${MV} ${WRKSRC_goleveldb} ${WRKSRC}/src/github.com/syndtr/goleveldb
	@${MV} ${WRKSRC_seelog} ${WRKSRC}/src/github.com/cihub/seelog
	@${MV} ${WRKSRC_zmq4} ${WRKSRC}/src/github.com/pebbe/zmq4
	@${MV} ${WRKSRC_golang_snappy} ${WRKSRC}/src/github.com/golang/snappy


do-build:
#	@cd ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME} && ${SETENV} GOPATH=${WRKSRC} go install ./...
	@cd ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME} && ${SETENV} GOPATH=${WRKSRC} go install .


do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bin/bitmarkd ${STAGEDIR}${PREFIX}/sbin
#	${INSTALL_MAN} ${WRKSRC}/man/bitmarkd.1 ${STAGEDIR}${MAN1PREFIX}/man/man1
	${INSTALL_DATA} ${WRKSRC}/bitmarkd.conf.sample ${STAGEDIR}${PREFIX}/etc/bitmarkd.conf.sample


.include <bsd.port.mk>
