import Foundation

public struct CreateSessionParameters: Codable {
    /// The format of input audio. Options are pcm16, g711_ulaw, or g711_alaw.
    /// For pcm16, input audio must be 16-bit PCM at a 24kHz sample rate, single channel (mono), and little-endian byte order.
    public let inputAudioFormat: SessionObject.AudioFormat?

    /// Configuration for input audio noise reduction.
    public let inputAudioNoiseReduction: SessionObject.InputAudioNoiseReduction?

    /// Configuration for input audio transcription.
    public let inputAudioTranscription: SessionObject.InputAudioTranscription?

    /// The default system instructions (i.e. system message) prepended to model calls.
    public let instructions: String?

    /// Maximum number of output tokens for a single assistant response.
    public let maxResponseOutputTokens: Int?

    /// The set of modalities the model can respond with.
    public let modalities: [SessionObject.Modality]?

    /// The Realtime model used for this session.
    public let model: String?

    /// The format of output audio.
    public let outputAudioFormat: SessionObject.AudioFormat?

    /// Sampling temperature for the model, limited to [0.6, 1.2].
    public let temperature: Double?

    /// How the model chooses tools.
    public let toolChoice: ToolChoice?

    /// Tools (functions) available to the model.
    public let tools: [Tool]?

    /// Configuration for turn detection.
    public let turnDetection: SessionObject.TurnDetection?

    /// The voice the model uses to respond.
    public let voice: String?

    enum CodingKeys: String, CodingKey {
        case inputAudioFormat = "input_audio_format"
        case inputAudioNoiseReduction = "input_audio_noise_reduction"
        case inputAudioTranscription = "input_audio_transcription"
        case instructions
        case maxResponseOutputTokens = "max_response_output_tokens"
        case modalities
        case model
        case outputAudioFormat = "output_audio_format"
        case temperature
        case toolChoice = "tool_choice"
        case tools
        case turnDetection = "turn_detection"
        case voice
    }

    public init(
        inputAudioFormat: SessionObject.AudioFormat? = nil,
        inputAudioNoiseReduction: SessionObject.InputAudioNoiseReduction? = nil,
        inputAudioTranscription: SessionObject.InputAudioTranscription? = nil,
        instructions: String? = nil,
        maxResponseOutputTokens: Int? = nil,
        modalities: [SessionObject.Modality]? = nil,
        model: String? = nil,
        outputAudioFormat: SessionObject.AudioFormat? = nil,
        temperature: Double? = nil,
        toolChoice: ToolChoice? = nil,
        tools: [Tool]? = nil,
        turnDetection: SessionObject.TurnDetection? = nil,
        voice: String? = nil
    ) {
        self.inputAudioFormat = inputAudioFormat
        self.inputAudioNoiseReduction = inputAudioNoiseReduction
        self.inputAudioTranscription = inputAudioTranscription
        self.instructions = instructions
        self.maxResponseOutputTokens = maxResponseOutputTokens
        self.modalities = modalities
        self.model = model
        self.outputAudioFormat = outputAudioFormat
        self.temperature = temperature
        self.toolChoice = toolChoice
        self.tools = tools
        self.turnDetection = turnDetection
        self.voice = voice
    }
}
