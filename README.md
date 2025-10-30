# Computer Architecture Course Projects - University of Tehran

![RISC-V](https://img.shields.io/badge/RISC--V-Processor_Design-blue) ![Verilog](https://img.shields.io/badge/Verilog-HDL-green) ![Pipeline](https://img.shields.io/badge/Pipeline-Architecture-orange) ![Computer Architecture](https://img.shields.io/badge/Computer-Architecture-purple)

A comprehensive collection of advanced computer architecture projects implementing various processor designs from fundamental digital logic to sophisticated pipelined RISC-V architectures.

## Project Team

**Contributors:**
- **Sajad Hassanpour** ([sajadhp](https://github.com/sajadhp1383)) - Team Lead & Hardware Architect
- **Erfan Falahati** ([erfan-f](https://github.com/erfan-f)) - Verification Engineer & System Designer

## Project Portfolio

### **CA1: Rat in Maze Solver** 
**Intelligent Back-Tracking Algorithm**
- **Technology**: Digital Logic Design, Finite State Machine
- **Key Features**:
  - 16×16 maze memory with wall detection
  - Intelligent rat with priority-based movement (Up → Right → Left → Down)
  - Back-tracking algorithm with stack implementation
  - Path optimization and storage in FIFO
- **Achievement**: Successful maze navigation with fail-safe detection

### **CA2: Single-Cycle RISC-V Processor**
**Complete ISA Implementation**
- **Instruction Set**: R-type, I-type, S-type, J-type, B-type, U-type
- **Supported Operations**: `add, sub, and, or, slt, lw, sw, addi, ori, slti, jalr, jal, beq, bne, lui`
- **Key Components**:
  - Structured datapath with combinatorial control unit
  - 32-bit unsigned array processing capability
  - Complete instruction decoding and execution
- **Application**: Finds largest element in 32-bit unsigned arrays

### **CA3: Multi-Cycle Stack-Based Processor**
**Custom Architecture Design**
- **Architecture**: Multi-cycle with 8-bit data bus, 22-bit address bus
- **Instruction Set**: 
  - Computational: `ADD, SUB, AND, NOT` 
  - Memory: `PUSH, POP`
  - Control: `JMP, JZ`
- **Stack Operations**: Internal 8×22-bit stack for all computations
- **Application**: Array summation with stack-based arithmetic

### **CA4: Pipelined RISC-V Processor**
**Advanced Processor Architecture**
- **Pipeline Stages**: Full 5-stage pipeline implementation
- **Hazard Handling**: Data hazard detection and forwarding units
- **Instruction Support**: Complete RISC-V subset including control flow
- **Optimization**: Pipeline stall minimization with advanced hazard resolution
- **Performance**: Efficient execution of complex algorithms on 20-element arrays

## Technical Implementation

### Hardware Description Languages
- **SystemVerilog/Verilog** - Industry-standard digital design
- **Structured & Behavioral Modeling** - Mixed abstraction levels

### Tools & Methodology
- **ModelSim** - Advanced simulation and verification
- **Quartus II** - FPGA synthesis and implementation
- **Huffman Coding** - Control unit design methodology
- **Pipeline Optimization** - Hazard detection and resolution

### Core Competencies Demonstrated

#### Processor Design
- **Single-cycle vs Multi-cycle vs Pipelined** architectures
- **RISC-V ISA** implementation and extension
- **Custom instruction set** design and optimization
- **Control unit design** with Huffman methodology

#### Memory & Storage Systems
- **Stack-based computation** architectures
- **Memory-mapped I/O** systems
- **Cache-less memory access** patterns
- **Data hazard resolution** in pipelined systems

#### Algorithm Implementation
- **Back-tracking algorithms** for path finding
- **Array processing** and statistical operations
- **Control flow management** in hardware
- **Performance optimization** techniques

## Key Technical Achievements

### Architecture Innovations
- **Four distinct processor architectures** from simple to complex
- **Complete RISC-V compliance** in single-cycle and pipelined implementations
- **Custom stack-based ISA** design and implementation
- **Advanced hazard resolution** in pipelined architecture

### Performance Highlights
- **Successful maze solving** with optimal path finding
- **Efficient array processing** on custom and standard ISAs
- **Pipeline throughput optimization** with minimal stalls
- **Robust error handling** and boundary condition management

### Research Contributions
- **Comparative analysis** of processor architectures
- **Performance trade-off studies** between different design approaches
- **Real-world algorithm implementation** in hardware

## 🔍 Academic Context

**Course**: Computer Architecture  
**Institution**: University of Tehran - Electrical and Computer Engineering Department  
**Semester**: Second Semester 1403-1404 (2024)  
**Level**: Advanced Undergraduate/Graduate


## Professional Value Proposition

This portfolio demonstrates exceptional capability in:

### Hardware Engineering Excellence
- **End-to-end processor design** from concept to implementation
- **Multiple architecture paradigms** and their trade-offs
- **Industry-standard methodologies** and tools

### Research & Development Skills
- **Algorithm-to-hardware translation** expertise
- **Performance analysis** and optimization techniques
- **Innovative problem-solving** in complex systems

### Engineering Leadership
- **System-level thinking** and architecture planning
- **Technical documentation** and presentation skills
- **Quality assurance** through comprehensive testing

*"This collection represents a comprehensive journey through computer architecture fundamentals, showcasing both theoretical understanding and practical implementation skills at an advanced level."*
