TARGET_DIR     = OS_LAB_TEST
INTERVAL_SECS  = 10
QUARANTINE_DIR = malicious_dir

$(QUARANTINE_DIR):
	mkdir -p $(QUARANTINE_DIR)

.PHONY: run-av
run-av: $(QUARANTINE_DIR)
	./antivirusd.sh $(TARGET_DIR) $(INTERVAL_SECS)

.PHONY: run-restore
run-restore: $(QUARANTINE_DIR)
	./restore.sh $(TARGET_DIR) $(QUARANTINE_DIR)

