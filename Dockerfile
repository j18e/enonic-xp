FROM enonic/xp-app:6.15.5

# Set Memory settings
# Defaults to 1/4 of servers physical mem
# On single cpu
# ENV JAVA_OPTS "-Xms2G -Xmx2G"
# On multi cpu systems
# ENV JAVA_OPTS "-Xms3G -Xmx3G -Djsse.enableSNIExtension=true -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=60 -XX:+ScavengeBeforeFullGC -XX:+CMSScavengeBeforeRemark"
# Dump memory to heapdum file on outofmem

ENV JAVA_OPTS "-Xms2048M -Xmx2048M -XX:+UseConcMarkSweepGC \
    -XX:+CMSParallelRemarkEnabled -XX:+UseCMSInitiatingOccupancyOnly \
    -XX:CMSInitiatingOccupancyFraction=60 -XX:+ScavengeBeforeFullGC \
    -XX:+CMSScavengeBeforeRemark -Djsse.enableSNIExtension=true \
    -XX:-HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/heapdump.hprof"

USER root

RUN cp -r $XP_ROOT/home.org $XP_HOME

RUN mkdir -p \
    $XP_HOME/deploy \
    $XP_HOME/snapshots \
    $XP_HOME/repo

RUN VERSION=1.0.5 \
    wget -O $XP_HOME/deploy/snapshotter-${VERSION}.jar \
    http://repo.enonic.com/public/com/enonic/app/snapshotter/${VERSION}/snapshotter-${VERSION}.jar

RUN VERSION=2.2.3 \
    wget -O $XP_HOME/deploy/ \
    https://dl.bintray.com/rcd-systems/rcd-repo/systems/rcd/enonic/datatoolbox/${VERSION}/datatoolbox-${VERSION}.jar

RUN chown $XP_USER:$XP_USER -R $XP_HOME

USER enonic-xp
