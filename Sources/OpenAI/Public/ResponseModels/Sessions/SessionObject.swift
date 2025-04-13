import Foundation

public struct SessionObject: Codable {
    /// The unique identifier for the session.
    public let id: String

    /// The object type, which is always "realtime.session".
    public let object: String

    /// The model used for this session.
    public let model: String

    /// The set of modalities the model can respond with.
    public let modalities: [Modality]

    /// The default system instructions (i.e. system message) prepended to model calls.
    public let instructions: String?

    /// The voice the model uses to respond.
    public let voice: String?

    /// The format of input audio.
    public let inputAudioFormat: AudioFormat?

    /// The format of output audio.
    public let outputAudioFormat: AudioFormat?

    /// Configuration for input audio transcription.
    public let inputAudioTranscription: InputAudioTranscription?

    /// Configuration for turn detection.
    public let turnDetection: TurnDetection?

    /// Tools (functions) available to the model.
    public let tools: [Tool]

    /// How the model chooses tools.
    public let toolChoice: ToolChoice

    /// Sampling temperature for the model.
    public let temperature: Double?

    /// Maximum number of output tokens for a single assistant response.
    public let maxResponseOutputTokens: MaxOutputTokens?

    /// The client secret containing the ephemeral API token.
    public let clientSecret: ClientSecret

    public enum AudioFormat: String, Codable {
        case pcm16 = "pcm16"
        case g711Ulaw = "g711_ulaw"
        case g711Alaw = "g711_alaw"
    }

    public struct InputAudioNoiseReduction: Codable {
        public let type: String?

        public init(type: String? = nil) {
            self.type = type
        }
    }

    public struct InputAudioTranscription: Codable {
        public let model: String?
        public let language: String?
        public let prompt: String?

        public init(model: String? = nil, language: String? = nil, prompt: String? = nil) {
            self.model = model
            self.language = language
            self.prompt = prompt
        }
    }

    public enum Modality: String, Codable {
        case text = "text"
        case audio = "audio"
    }

    public struct TurnDetection: Codable {
        public let createResponse: Bool?
        public let eagerness: TurnDetectionEagerness?
        public let interruptResponse: Bool?
        public let prefixPaddingMs: Int?
        public let silenceDurationMs: Int?
        public let threshold: Double?
        public let type: TurnDetectionType

		public enum TurnDetectionType: String, Codable, Sendable {
			case serverVad = "server_vad"
			case semanticVad = "semantic_vad"
			case none
		}

		public enum TurnDetectionEagerness: String, Codable, Sendable {
			case low
			case high
			case auto
			case medium
		}

        enum CodingKeys: String, CodingKey {
            case createResponse = "create_response"
            case eagerness
            case interruptResponse = "interrupt_response"
            case prefixPaddingMs = "prefix_padding_ms"
            case silenceDurationMs = "silence_duration_ms"
            case threshold
            case type
        }

        public init(
            type: TurnDetectionType,
            createResponse: Bool? = nil,
            eagerness: TurnDetectionEagerness? = nil,
            interruptResponse: Bool? = nil,
            prefixPaddingMs: Int? = nil,
            silenceDurationMs: Int? = nil,
            threshold: Double? = nil
        ) {
            self.type = type
            self.createResponse = createResponse
            self.eagerness = eagerness
            self.interruptResponse = interruptResponse
            self.prefixPaddingMs = prefixPaddingMs
            self.silenceDurationMs = silenceDurationMs
            self.threshold = threshold
        }
    }

    public struct ClientSecret: Codable {
        /// The ephemeral API token value.
        public let value: String

        /// The Unix timestamp (in seconds) when the token expires.
        public let expiresAt: Int

        private enum CodingKeys: String, CodingKey {
            case value
            case expiresAt = "expires_at"
        }
    }

    public enum MaxOutputTokens: Codable {
        case inf
        case int(Int)

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let intValue = try? container.decode(Int.self) {
                self = .int(intValue)
            } else if let stringValue = try? container.decode(String.self), stringValue == "inf" {
                self = .inf
            } else {
                throw DecodingError.typeMismatch(MaxOutputTokens.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MaxOutputTokens"))
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .inf:
                try container.encode("inf")
            case .int(let value):
                try container.encode(value)
            }
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case object
        case model
        case modalities
        case instructions
        case voice
        case inputAudioFormat = "input_audio_format"
        case outputAudioFormat = "output_audio_format"
        case inputAudioTranscription = "input_audio_transcription"
        case turnDetection = "turn_detection"
        case tools
        case toolChoice = "tool_choice"
        case temperature
        case maxResponseOutputTokens = "max_response_output_tokens"
        case clientSecret = "client_secret"
    }
}
