FROM gepetto/utils:vnc

RUN sudo sed -i 's/(ALL:ALL) ALL/(ALL) NOPASSWD: ALL/' /etc/sudoers # Enable sudo without password

RUN sudo apt-get update && \
    sudo apt-get install -y terminator \
                            python3-numpy \
                            python3-scipy \
                            python3-matplotlib \
                            spyder3 \ 
                            curl \
                            firefox \
                            build-essential \
                            nano

RUN sudo sh -c "echo 'deb [arch=amd64] http://robotpkg.openrobots.org/packages/debian/pub $(lsb_release -sc) robotpkg' >> /etc/apt/sources.list.d/robotpkg.list"
RUN sudo sh -c "echo 'deb [arch=amd64] http://robotpkg.openrobots.org/wip/packages/debian/pub $(lsb_release -sc) robotpkg' >> /etc/apt/sources.list.d/robotpkg.list"
RUN curl http://robotpkg.openrobots.org/packages/debian/robotpkg.key | sudo apt-key add -

RUN sudo apt-get update && \
    sudo apt-get install -y robotpkg-py38-pinocchio \
                        robotpkg-py38-example-robot-data \
                        robotpkg-urdfdom \
                        robotpkg-py38-qt5-gepetto-viewer-corba \
                        robotpkg-py38-quadprog \
                        robotpkg-py38-tsid

RUN echo "export PATH=/opt/openrobots/bin:$PATH" >> /home/user/entrypoint.sh
RUN echo "export PATH=/opt/openrobots/bin:$PATH" >> /home/user/entrypoint.sh
RUN echo "export PKG_CONFIG_PATH=/opt/openrobots/lib/pkgconfig" >> /home/user/entrypoint.sh
RUN echo "export LD_LIBRARY_PATH=/opt/openrobots/lib" >> /home/user/entrypoint.sh
RUN echo "export ROS_PACKAGE_PATH=/opt/openrobots/share" >> /home/user/entrypoint.sh
RUN echo "export PYTHONPATH=/opt/openrobots/lib/python3.8/site-packages:/home/user/Desktop/orc" >> /home/user/entrypoint.sh

RUN echo "sudo chown user:user /home/user/Desktop" >> /home/user/entrypoint.sh
RUN echo "if [ ! -d /home/user/Desktop/orc ]; then mkdir -p /home/user/Desktop/orc; fi;" >> /home/user/entrypoint.sh
RUN echo "if [ ! -f /home/user/Desktop/firefox.desktop ]; then ln -s /usr/share/applications/firefox.desktop /home/user/Desktop/firefox.desktop; fi;" >> /home/user/entrypoint.sh

RUN echo "docker-vnc" >> /home/user/entrypoint.sh

RUN sudo chown user:user /usr/share/applications/firefox.desktop && chmod +x /usr/share/applications/firefox.desktop

CMD sh /home/user/entrypoint.sh