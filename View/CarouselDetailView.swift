import SwiftUI

struct CarouselDetailView: View {
    let item: ImageModel
    let animation: Namespace.ID

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ZStack(alignment: .bottomLeading) {
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 560)
                        .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                        .overlay {
                            LinearGradient(
                                colors: [
                                    .black.opacity(0.05),
                                    .black.opacity(0.2),
                                    .black.opacity(0.55),
                                    .black
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
                        }
                        .navigationTransition(.zoom(sourceID: item.id, in: animation))

                    VStack(alignment: .leading, spacing: 10) {
                        Text(item.title.uppercased())
                            .font(.system(size: 38, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .lineLimit(2)

                        Text(item.category.uppercased())
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.9))

                        Text(item.metadataLine)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.85))

                        HStack(spacing: 14) {
                            Button {
                            } label: {
                                Label("Add to Library", systemImage: "book.closed.fill")
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                    .padding(.horizontal, 28)
                                    .frame(height: 52)
                                    .background(.white, in: Capsule())
                            }

                            Button {
                            } label: {
                                Image(systemName: "square.and.arrow.down.fill")
                                    .font(.title3.weight(.semibold))
                                    .foregroundStyle(.white)
                                    .frame(width: 52, height: 52)
                                    .background(.white.opacity(0.18), in: Circle())
                            }
                        }
                    }
                    .padding(28)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Overview")
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)

                    Text(item.summary)
                        .font(.body)
                        .foregroundStyle(.white.opacity(0.82))

                    Text(item.metadataLine)
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.6))
                        .padding(.top, 4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 40)
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

#Preview {
    @Previewable @Namespace var animation

    NavigationStack {
        CarouselDetailView(item: images[0], animation: animation)
    }
}
