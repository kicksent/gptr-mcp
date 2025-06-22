# GPT-Researcher MCP Server

This file provides guidance to Claude Code (claude.ai/code) when working with the GPT-Researcher MCP (Model Context Protocol) server.

## Project Overview

The GPT-Researcher MCP Server is a Model Context Protocol implementation that provides AI assistants with direct access to GPT-Researcher's autonomous research capabilities. It uses streamable HTTP transport for real-time communication and enables AI assistants like Claude Desktop to perform comprehensive web research through the MCP protocol.

## Architecture

This MCP server bridges the gap between AI assistants and the GPT-Researcher engine:

- **MCP Protocol Implementation**: Streamable HTTP transport for real-time communication
- **GPT-Researcher Integration**: Direct access to core research engine capabilities
- **Session Management**: Stateful session handling for research workflows
- **HTTP Streaming**: Real-time progress updates during research operations

## Development Commands

### Running the MCP Server
```bash
# Start the MCP server (preferred method)
uv run server.py

# Alternative: Run with Python
python server.py

# Development mode with auto-reload
uv run --reload server.py
```

### Testing the Server
```bash
# Test MCP server connectivity
curl http://localhost:8000/mcp

# Test with MCP client
python test_mcp_server.py
```

## Configuration

### Environment Variables
- `OPENAI_API_KEY` / `ANTHROPIC_API_KEY`: LLM provider keys
- `TAVILY_API_KEY`: Default web search engine
- `DOC_PATH`: Local documents directory for research
- `RETRIEVER`: Search engine selection (tavily, google, bing, duckduckgo, etc.)
- `REPORT_TYPE`: Output format (research_report, detailed_report, etc.)

### Server Configuration
- **Port**: 8000
- **Endpoint**: `/mcp`
- **Transport**: streamable-http
- **Session Management**: Enabled for research workflows

## Git Remote Configuration

This repository is configured with multiple remotes for development workflow:

- **origin**: `https://github.com/kicksent/gptr-mcp.git` (your fork for pushing changes)
- **upstream**: `git@github.com:assafelovic/gptr-mcp.git` (original repository for pulling updates)

### Common Git Workflows
```bash
# Push changes to your fork
git push origin branch-name

# Pull updates from original repository
git pull upstream main

# Create feature branch
git checkout -b feature/your-feature-name

# Push feature branch to fork for PR
git push origin feature/your-feature-name
```

## MCP Server Features

### Core Capabilities
- **Research Tool**: Autonomous web research with citations
- **Report Generation**: Detailed research reports in multiple formats
- **Real-time Updates**: Streaming progress updates during research
- **Multi-source Data**: Integration with multiple search engines and data sources

### Transport Protocol
- **Type**: streamable-http
- **Session ID**: Required for maintaining research context
- **Headers**: Must include `mcp-session-id` for subsequent requests
- **Streaming**: Server-sent events format for real-time updates

### Integration Points
- **Claude Desktop**: Direct integration via MCP protocol
- **AI Assistants**: Generic MCP client support
- **Custom Clients**: HTTP-based API for custom integrations

## Implementation Notes

### HTTP Streaming Fixes
This implementation includes several fixes for HTTP streaming functionality:

1. **Session Management**: Proper session ID handling for stateful research workflows
2. **Transport Configuration**: Streamable HTTP transport with proper endpoint configuration
3. **Error Handling**: Comprehensive error handling for network and API failures
4. **Logging**: Detailed logging for debugging and monitoring

### Key Dependencies
- **GPT-Researcher**: Core research engine
- **MCP SDK**: Model Context Protocol implementation
- **FastAPI**: HTTP server framework
- **Uvicorn**: ASGI server for production deployment

## Usage Examples

### Starting the Server
```bash
# Navigate to gpt-researcher directory
cd /path/to/gpt-researcher

# Start the MCP server
uv run gptr-mcp/server.py
```

### Expected Output
```
[2025-06-22 12:02:32,220][INFO] - Starting GPT Researcher MCP Server with streamable-http transport...
🚀 GPT Researcher MCP Server starting with streamable-http transport...
   Check researcher_mcp_server.log for details
[2025-06-22 12:02:32,220][INFO] - Using streamable-http transport
[06/22/25 12:02:32] INFO     Starting MCP server 'GPT Researcher' with transport 'streamable-http' on http://0.0.0.0:8000/mcp
INFO:     Started server process [79435]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
```

## Integration with Broader System

This MCP server is part of a larger book recommendation system that includes:

1. **GPT-Researcher MCP Server** (this project): Core research capabilities
2. **MCP Servers**: Additional specialized servers for book data and Reddit analysis
3. **Frontend Application**: NextJS-based user interface
4. **Book Server**: Metadata and enrichment services

### Deployment Sequence
1. Start GPT-Researcher MCP Server: `uv run gptr-mcp/server.py`
2. Start other MCP servers: `./start-all.sh` in mcp-servers directory
3. Start frontend services: `docker-compose up`

## Troubleshooting

### Common Issues
- **Port Conflicts**: Ensure port 8000 is available
- **Environment Variables**: Verify all required API keys are set
- **Session Management**: Check session ID handling in client implementations
- **HTTP Streaming**: Verify streamable-http transport configuration

### Debugging
- **Logs**: Check `researcher_mcp_server.log` for detailed server logs
- **Network**: Verify server is accessible at `http://localhost:8000/mcp`
- **MCP Protocol**: Ensure client sends proper MCP headers and session IDs

## Recent Changes & Fixes

### HTTP Streaming Implementation
- Fixed streamable-http transport configuration
- Added proper session management for research workflows
- Improved error handling and logging
- Updated dependencies and configuration files

### Integration Improvements
- Enhanced compatibility with parent GPT-Researcher project
- Streamlined startup process with uv package manager
- Updated environment variable handling
- Improved documentation and usage examples