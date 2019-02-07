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

ENV SNAPSHOTTER_VERSION=1.0.5
ENV DATATOOLBOX_VERSION=2.2.3

RUN cd $XP_HOME/deploy && \
    wget http://repo.enonic.com/public/com/enonic/app/snapshotter/${SNAPSHOTTER_VERSION}/snapshotter-${SNAPSHOTTER_VERSION}.jar && \
    wget https://dl.bintray.com/rcd-systems/rcd-repo/systems/rcd/enonic/datatoolbox/${DATATOOLBOX_VERSION}/datatoolbox-${DATATOOLBOX_VERSION}.jar

RUN chown $XP_USER:$XP_USER -R $XP_HOME

USER enonic-xp
