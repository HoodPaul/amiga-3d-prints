# Amiga Zorro LAN IDE CP: Ethernet bezel spacers

Two printed spacer blocks mount the Ethernet daughterboard of the **Amiga Zorro LAN IDE CP card** to a metal expansion-slot bezel. The blocks bridge the offset between the board mounting holes and the bezel tabs.

## Compatible bezel

Designed around the bezel supplied as **“Metal bezel slot bezel XT 8-bit Ethernet controller”**, [eBay item 397937168243](https://www.ebay.co.uk/itm/397937168243). This is the specific bezel used for the fit test, not a claim of compatibility with all PCI or XT brackets.

## Files

Each STL contains a pair of blocks. Dimensions are in millimetres.

| Height | Printable file |
|---|---|
| 12 mm | [Pair-12mm-v0.2.stl](stl/Pair-12mm-v0.2.stl) |
| 13 mm | [Pair-13mm-v0.2.stl](stl/Pair-13mm-v0.2.stl) |
| 14 mm | [Pair-14mm-v0.2.stl](stl/Pair-14mm-v0.2.stl) |
| 15 mm | [Pair-15mm-v0.2.stl](stl/Pair-15mm-v0.2.stl) |
| 16 mm | [Pair-16mm-v0.2.stl](stl/Pair-16mm-v0.2.stl) |

[Editable OpenSCAD source](source/Zorro-LAN-IDE-CP-bezel-spacers.scad). Set `height` and export; do not scale the STL, as that changes screw and nut clearances.

## Mounting

The PCB sits above the blocks, with its socket and components underneath. The Ethernet socket faces out through the bezel opening.

1. Insert an M3 nut into each side-loading PCB nut pocket.
2. Attach the blocks to the inward-bent metal bezel tabs through the recessed channels and bottom slots.
3. Fit the PCB using the third large hole counting inward from each outer edge. Fit the block whose hole setback matches that side.
4. Secure the PCB to the captive nuts, checking socket alignment and component clearance before tightening.

The bracket tabs appear to have threaded inserts. Confirm their thread before using M3 screws; do not force an incompatible screw. For clearance-hole tabs, a separate nut may be used underneath where accessible. Lower bracket fixings do not have captive nuts. Screw lengths depend on the actual tab and PCB thickness.

## Design and printing

- Block footprint: 18 × 14 mm.
- PCB fixing holes: 3.4 mm.
- Captive M3 nut pockets: 5.7 mm across flats, 2.6 mm thick.
- Floor below recessed fixing channels: 2 mm.
- V0.2 extends both channel closed ends and their matching bottom slots by 0.5 mm.
- Print flat as supplied at 100% scale. Suggested starting settings: 0.2 mm layers, four walls and 40% infill. Clear any bridging sag from the nut pockets.

The PCB mounting positions were derived from the supplied ZORRO-LAN-IDE-CP-V2EFront Gerber/drill files. Bezel offsets were initially estimated.

## Fit status

The 14 mm height was reported to fit well in a physical print test. V0.2 incorporates the subsequent requested 0.5 mm channel/slot extension. The other heights are alternatives, not separately confirmed physical fits. All five generated STL meshes were checked for closed surfaces and correct height.

This project is the Ethernet daughterboard bezel adaptor, not the separate A4000 rear-panel NIC bracket.
