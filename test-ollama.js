// Test script to check Ollama connection
import ollama from "ollama";

async function testOllama() {
    try {
        console.log("Testing Ollama connection...");
        
        // Test 1: List models
        console.log("1. Listing models...");
        const modelsResponse = await ollama.list();
        console.log("Models:", modelsResponse.models.map(m => m.name));
        
        // Test 2: Simple chat
        console.log("2. Testing chat...");
        const response = await ollama.chat({
            model: 'llama3.2',
            messages: [{ role: 'user', content: 'Say hello in one word' }],
        });
        console.log("Chat response:", response.message.content);
        
        console.log("✅ Ollama connection test successful!");
        
    } catch (error) {
        console.error("❌ Ollama connection test failed:");
        console.error("Error:", error.message);
        console.error("Stack:", error.stack);
    }
}

testOllama();
