wvCreateWindow
wvOpenFile -win $_nWave2 {/home/qidc/Nutstore/Project/config/QA_DIR/rtl.fsdb}
wvRestoreSignal -win $_nWave2 "signal.rc" -overWriteAutoAlias on -appendSignals \
           on
debExit
