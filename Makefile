PCB_FILE := MicroBaro-Core.kicad_pcb
RENDER_DIR := assets
RENDER := kicad-cli pcb render
RENDER_SIZE := -w 1920 -h 1920

TOP_VIEW := $(RENDER_DIR)/top.png
BOTTOM_VIEW := $(RENDER_DIR)/bottom.png
ISO_VIEW := $(RENDER_DIR)/iso.png
ISO_REAR_VIEW := $(RENDER_DIR)/iso-rear.png

$(RENDER_DIR):
	mkdir -p $(RENDER_DIR)

all: $(TOP_VIEW) $(BOTTOM_VIEW) $(ISO_VIEW) $(ISO_REAR_VIEW)

$(TOP_VIEW): $(PCB_FILE) | $(RENDER_DIR)
	$(RENDER) $(RENDER_SIZE) --side top --rotate "0,0,-90" $< --output $@

$(BOTTOM_VIEW): $(PCB_FILE) | $(RENDER_DIR)
	$(RENDER) $(RENDER_SIZE) --side bottom --rotate "0,0,90" $< --output $@

$(ISO_VIEW): $(PCB_FILE) | $(RENDER_DIR)
	$(RENDER) $(RENDER_SIZE) --side top --zoom 0.75 --rotate "315,0,-45" $< --output $@

$(ISO_REAR_VIEW): $(PCB_FILE) | $(RENDER_DIR)
	$(RENDER) $(RENDER_SIZE) --side top --zoom 0.75 --rotate "315,0,45" $< --output $@

clean:
	rm -rf $(RENDER_DIR)

.PHONY: all clean
